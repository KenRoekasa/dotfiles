-- CLion-style CMake panel: bottom split with tabs (configure / build / run /
-- terminal), winbar with clickable tabs + stop button, CMake File API for
-- target enumeration, recent targets, command queue, persistent terminal.
--
-- Ported and adapted from https://github.com/williamlouth/nvim and
-- https://github.com/arbareus/arbareus (MIT license).
local M = {}

M.build_dir = 'cmake-build-debug'
M.build_type = 'Debug'
M.last_target = nil
M.last_run_target = nil
M.configure_preset = nil
M.build_preset = nil

-- Target history (most recent first, max 5)
local target_history = {}

local function add_to_target_history(name)
  for i, t in ipairs(target_history) do
    if t == name then
      table.remove(target_history, i)
      break
    end
  end
  table.insert(target_history, 1, name)
  while #target_history > 5 do
    table.remove(target_history)
  end
end

-- Panel state
local panel = {
  win = nil,
  bufs = { configure = nil, build = nil, run = nil, terminal = nil },
  jobs = { configure = nil, build = nil, run = nil, terminal = nil },
  active_tab = nil,
  height = 15,
  collapsed = false,
}

-- Command queue: items are functions to call when the current job finishes
local command_queue = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = 'CMake' })
end

local function file_exists(path)
  return vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1
end

local function read_presets()
  local presets_file = vim.fn.getcwd() .. '/CMakePresets.json'
  local user_presets_file = vim.fn.getcwd() .. '/CMakeUserPresets.json'
  local file = nil
  if vim.fn.filereadable(presets_file) == 1 then
    file = presets_file
  elseif vim.fn.filereadable(user_presets_file) == 1 then
    file = user_presets_file
  end
  if not file then return nil end
  local content = table.concat(vim.fn.readfile(file), '\n')
  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    notify('Failed to parse ' .. vim.fn.fnamemodify(file, ':t'), vim.log.levels.WARN)
    return nil
  end
  return data
end

local function get_configure_presets()
  local data = read_presets()
  if not data or not data.configurePresets then return {} end
  local presets = {}
  for _, p in ipairs(data.configurePresets) do
    if not p.hidden then table.insert(presets, p.name) end
  end
  return presets
end

local function get_build_presets()
  local data = read_presets()
  if not data or not data.buildPresets then return {} end
  local presets = {}
  for _, p in ipairs(data.buildPresets) do
    if not p.hidden then table.insert(presets, p.name) end
  end
  return presets
end

local function get_preset_binary_dir()
  local data = read_presets()
  if not data or not data.configurePresets or not M.configure_preset then return nil end
  for _, p in ipairs(data.configurePresets) do
    if p.name == M.configure_preset and p.binaryDir then
      return p.binaryDir:gsub('%${sourceDir}', vim.fn.getcwd())
    end
  end
  return nil
end

local function get_build_dir()
  local preset_dir = get_preset_binary_dir()
  if preset_dir then return preset_dir end
  return vim.fn.getcwd() .. '/' .. M.build_dir
end

local function panel_is_open()
  return panel.win and vim.api.nvim_win_is_valid(panel.win)
end

local function scroll_panel_to_bottom()
  if not panel_is_open() then return end
  local buf = vim.api.nvim_win_get_buf(panel.win)
  local line_count = vim.api.nvim_buf_line_count(buf)
  vim.api.nvim_win_set_cursor(panel.win, { line_count, 0 })
end

local function panel_winbar()
  local tabs = { 'configure', 'build', 'run', 'terminal' }
  local labels = { configure = ' CMake', build = ' Build', run = ' Run', terminal = ' Terminal' }
  local parts = {}
  if panel.active_tab and panel.jobs[panel.active_tab] then
    table.insert(parts, '%@v:lua.cmake_click_stop@%#CMakePanelStop#  Stop %X')
  end
  for _, tab in ipairs(tabs) do
    local hl = (panel.active_tab == tab) and '%#CMakePanelActive#' or '%#CMakePanelInactive#'
    local click = string.format('%%@v:lua.cmake_click_%s@', tab)
    table.insert(parts, click .. hl .. ' ' .. labels[tab] .. ' %X')
  end
  local left = table.concat(parts, '%#CMakePanelSep# │ ')
  return left .. '%=' .. '%@v:lua.cmake_click_close@%#CMakePanelClose# X %X'
end

local function ensure_panel()
  if panel_is_open() then return end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'hide'
  vim.cmd('botright ' .. panel.height .. 'split')
  panel.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(panel.win, buf)
  vim.wo[panel.win].number = false
  vim.wo[panel.win].relativenumber = false
  vim.wo[panel.win].signcolumn = 'no'
  vim.wo[panel.win].winfixheight = true
  vim.cmd 'wincmd p'
end

local function show_tab(tab)
  ensure_panel()
  panel.active_tab = tab
  if panel.collapsed then
    panel.collapsed = false
    vim.api.nvim_win_set_height(panel.win, panel.height)
  end
  local buf = panel.bufs[tab]
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_win_set_buf(panel.win, buf)
  end
  vim.wo[panel.win].winbar = panel_winbar()
  scroll_panel_to_bottom()
end

local function kill_job(tab)
  local job_id = panel.jobs[tab]
  if job_id then
    pcall(vim.fn.jobstop, job_id)
    panel.jobs[tab] = nil
  end
end

local function any_job_running()
  for tab, job_id in pairs(panel.jobs) do
    if job_id and tab ~= 'terminal' then return true end
  end
  return false
end

local function drain_queue()
  if #command_queue > 0 then
    local next_cmd = table.remove(command_queue, 1)
    next_cmd()
  end
end

local function run_in_panel(tab, cmd, on_complete)
  kill_job(tab)
  local old_buf = panel.bufs[tab]
  if old_buf and vim.api.nvim_buf_is_valid(old_buf) then
    pcall(vim.api.nvim_buf_delete, old_buf, { force = true })
  end
  ensure_panel()
  if panel.collapsed then
    panel.collapsed = false
    vim.api.nvim_win_set_height(panel.win, panel.height)
  end
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(panel.win)
  local new_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(panel.win, new_buf)
  local job_id = vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code)
      panel.jobs[tab] = nil
      vim.schedule(function()
        if panel_is_open() then vim.wo[panel.win].winbar = panel_winbar() end
        if on_complete then on_complete(exit_code) else drain_queue() end
      end)
    end,
  })
  panel.jobs[tab] = job_id
  panel.bufs[tab] = vim.api.nvim_get_current_buf()
  panel.active_tab = tab
  pcall(vim.api.nvim_buf_set_name, panel.bufs[tab], 'cmake://' .. tab)
  local term_buf = panel.bufs[tab]
  vim.api.nvim_buf_attach(term_buf, false, {
    on_lines = function(_, buf)
      if panel_is_open() and vim.api.nvim_win_get_buf(panel.win) == buf then
        vim.schedule(function()
          if panel_is_open() and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_get_buf(panel.win) == buf then
            pcall(vim.api.nvim_win_set_cursor, panel.win, { vim.api.nvim_buf_line_count(buf), 0 })
          end
        end)
      end
    end,
  })
  vim.wo[panel.win].winbar = panel_winbar()
  scroll_panel_to_bottom()
  vim.api.nvim_set_current_win(cur_win)
end

function M.stop_current()
  local tab = panel.active_tab
  if not tab then notify('Nothing running.') return end
  if panel.jobs[tab] then
    kill_job(tab)
    command_queue = {}
    notify('Stopped: ' .. tab .. ' (queue cleared)')
    if panel_is_open() then vim.wo[panel.win].winbar = panel_winbar() end
  else
    notify('Nothing running in ' .. tab .. ' tab.')
  end
end

function M.collapse_panel()
  if not panel_is_open() then return end
  panel.collapsed = true
  local blank = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(panel.win, blank)
  vim.api.nvim_win_set_height(panel.win, 1)
  vim.wo[panel.win].winbar = panel_winbar()
end

-- Global click handlers
_G.cmake_click_configure = function() show_tab 'configure' end
_G.cmake_click_build     = function() show_tab 'build' end
_G.cmake_click_run       = function() show_tab 'run' end
_G.cmake_click_terminal  = function() M.show_terminal() end
_G.cmake_click_stop      = function() M.stop_current() end
_G.cmake_click_close     = function() M.collapse_panel() end
_G.cmake_click_target             = function() M.select_target() end
_G.cmake_click_configure_preset   = function() M.select_configure_preset() end
_G.cmake_click_build_preset       = function() M.select_build_preset() end

local function ensure_cmake_api_query(build_dir)
  local query_dir = build_dir .. '/.cmake/api/v1/query'
  vim.fn.mkdir(query_dir, 'p')
  local codemodel_query = query_dir .. '/codemodel-v2'
  if vim.fn.filereadable(codemodel_query) == 0 then
    vim.fn.writefile({}, codemodel_query)
  end
end

function M.configure()
  local function do_configure_now()
    local configure_presets = get_configure_presets()
    if #configure_presets > 0 then
      local function do_configure(preset)
        M.configure_preset = preset
        local presets = read_presets()
        if presets and presets.configurePresets then
          for _, p in ipairs(presets.configurePresets) do
            if p.name == preset and p.binaryDir then
              ensure_cmake_api_query(p.binaryDir:gsub('%${sourceDir}', vim.fn.getcwd()))
              break
            end
          end
        end
        notify('Configuring preset: ' .. preset)
        run_in_panel('configure', 'cmake --preset ' .. preset)
      end
      if M.configure_preset and vim.tbl_contains(configure_presets, M.configure_preset) then
        do_configure(M.configure_preset)
      else
        vim.ui.select(configure_presets, { prompt = 'Select configure preset:' }, function(choice)
          if choice then do_configure(choice) end
        end)
      end
    else
      local build_dir = get_build_dir()
      vim.fn.mkdir(build_dir, 'p')
      ensure_cmake_api_query(build_dir)
      local cmd = string.format('cmake -B %s -DCMAKE_BUILD_TYPE=%s -G Ninja', M.build_dir, M.build_type)
      notify('Configuring...')
      run_in_panel('configure', cmd)
    end
  end
  if any_job_running() then
    notify('Queued: configure')
    table.insert(command_queue, do_configure_now)
  else
    do_configure_now()
  end
end

function M.build()
  local function do_build_now()
    local build_presets = get_build_presets()
    if #build_presets > 0 then
      local function do_build(preset)
        M.build_preset = preset
        notify('Building all (preset: ' .. preset .. ')')
        run_in_panel('build', 'cmake --build --preset ' .. preset)
      end
      if M.build_preset and vim.tbl_contains(build_presets, M.build_preset) then
        do_build(M.build_preset)
      else
        vim.ui.select(build_presets, { prompt = 'Select build preset:' }, function(choice)
          if choice then do_build(choice) end
        end)
      end
    else
      local build_dir = get_build_dir()
      if not file_exists(build_dir .. '/build.ninja') and not file_exists(build_dir .. '/Makefile') then
        notify('No build system found. Configure first (<S-F12>).', vim.log.levels.WARN)
        return
      end
      notify('Building all...')
      run_in_panel('build', 'cmake --build ' .. build_dir)
    end
  end
  if any_job_running() then
    notify('Queued: build all')
    table.insert(command_queue, do_build_now)
  else
    do_build_now()
  end
end

function M.run_last()
  if not M.last_run_target then
    notify('No run target selected. Use <leader>cs to select one.', vim.log.levels.WARN)
    return
  end
  local function do_run_now()
    local target = M.last_run_target
    local build_dir = get_build_dir()
    local function do_run()
      local executable = build_dir .. '/' .. target
      if not file_exists(executable) then
        local found = vim.fn.globpath(build_dir, '**/' .. vim.fn.fnamemodify(target, ':t'), false, true)
        if type(found) == 'table' and #found > 0 then
          executable = found[1]
        elseif type(found) == 'string' and found ~= '' then
          executable = vim.split(found, '\n')[1]
        else
          notify('Executable not found: ' .. target, vim.log.levels.WARN)
          return
        end
      end
      notify('Running: ' .. vim.fn.fnamemodify(executable, ':t'))
      run_in_panel('run', executable)
    end
    local build_presets = get_build_presets()
    local cmd
    if #build_presets > 0 and M.build_preset then
      cmd = 'cmake --build --preset ' .. M.build_preset .. ' --target ' .. target
    else
      if not file_exists(build_dir .. '/build.ninja') and not file_exists(build_dir .. '/Makefile') then
        notify('No build system found. Configure first (<S-F12>).', vim.log.levels.WARN)
        return
      end
      cmd = 'cmake --build ' .. build_dir .. ' --target ' .. target
    end
    notify('Building ' .. target .. '...')
    run_in_panel('build', cmd, function(exit_code)
      if exit_code == 0 then do_run()
      else
        notify('Build failed (exit ' .. exit_code .. '). Not running.', vim.log.levels.ERROR)
        drain_queue()
      end
    end)
  end
  if any_job_running() then
    notify('Queued: build + run ' .. M.last_run_target)
    table.insert(command_queue, do_run_now)
  else
    do_run_now()
  end
end

local function get_targets(callback)
  local build_dir = get_build_dir()
  if not file_exists(build_dir) then
    notify('Build directory not found. Configure first.', vim.log.levels.WARN)
    return
  end
  local query_dir = build_dir .. '/.cmake/api/v1/query'
  vim.fn.mkdir(query_dir, 'p')
  local codemodel_query = query_dir .. '/codemodel-v2'
  if vim.fn.filereadable(codemodel_query) == 0 then vim.fn.writefile({}, codemodel_query) end
  local reply_dir = build_dir .. '/.cmake/api/v1/reply'
  if not file_exists(reply_dir) then
    notify('No CMake API reply found. Configure first (<S-F12>).', vim.log.levels.WARN)
    return
  end
  local reply_files = vim.fn.globpath(reply_dir, 'codemodel-*.json', false, true)
  if type(reply_files) == 'string' then
    reply_files = reply_files ~= '' and vim.split(reply_files, '\n') or {}
  end
  if #reply_files == 0 then
    notify('No codemodel file found. Configure first (<S-F12>).', vim.log.levels.WARN)
    return
  end
  local ok, codemodel = pcall(vim.json.decode, table.concat(vim.fn.readfile(reply_files[1]), '\n'))
  if not ok or not codemodel then
    notify('Failed to parse codemodel JSON', vim.log.levels.ERROR)
    return
  end
  local config_targets = {}
  if codemodel.configurations then
    for _, cfg in ipairs(codemodel.configurations) do
      if cfg.targets then config_targets = cfg.targets break end
    end
  end
  if #config_targets == 0 then notify('No targets found.', vim.log.levels.WARN) return end
  local targets = {}
  for _, t in ipairs(config_targets) do
    local target_file = reply_dir .. '/' .. t.jsonFile
    if vim.fn.filereadable(target_file) == 1 then
      local tok, info = pcall(vim.json.decode, table.concat(vim.fn.readfile(target_file), '\n'))
      if tok and info and info.name and not info.name:find '_autogen' then
        table.insert(targets, { name = info.name, type = (info.type or ''):lower():gsub('_', ' ') })
      end
    end
  end
  if #targets == 0 then notify('No valid targets found.', vim.log.levels.WARN) return end
  callback(targets)
end

function M.select_target()
  get_targets(function(targets)
    local items, seen = {}, {}
    for _, hist_name in ipairs(target_history) do
      for _, t in ipairs(targets) do
        if t.name == hist_name then
          table.insert(items, { name = t.name, type = t.type, recent = true })
          seen[t.name] = true
          break
        end
      end
    end
    for _, t in ipairs(targets) do
      if not seen[t.name] then
        table.insert(items, { name = t.name, type = t.type, recent = false })
      end
    end
    local display = {}
    for _, item in ipairs(items) do
      table.insert(display, (item.recent and '⏱ ' or '  ') .. item.name .. ' (' .. item.type .. ')')
    end
    vim.ui.select(display, { prompt = 'Select CMake target (recent first):' }, function(_, idx)
      if idx then
        local choice = items[idx].name
        M.last_target = choice
        M.last_run_target = choice
        add_to_target_history(choice)
        notify('Target set: ' .. choice)
        if panel_is_open() then vim.wo[panel.win].winbar = panel_winbar() end
        vim.cmd 'redrawstatus'
      end
    end)
  end)
end

function M.select_configure_preset()
  local presets = get_configure_presets()
  if #presets == 0 then notify('No configure presets found.', vim.log.levels.WARN) return end
  vim.ui.select(presets, { prompt = 'Select configure preset:' }, function(choice)
    if choice then
      M.configure_preset = choice
      notify('Configure preset: ' .. choice)
      if panel_is_open() then vim.wo[panel.win].winbar = panel_winbar() end
      vim.cmd 'redrawstatus'
    end
  end)
end

function M.select_build_preset()
  local presets = get_build_presets()
  if #presets == 0 then notify('No build presets found.', vim.log.levels.WARN) return end
  vim.ui.select(presets, { prompt = 'Select build preset:' }, function(choice)
    if choice then
      M.build_preset = choice
      notify('Build preset: ' .. choice)
      if panel_is_open() then vim.wo[panel.win].winbar = panel_winbar() end
      vim.cmd 'redrawstatus'
    end
  end)
end

function M.toggle_panel()
  if panel_is_open() then
    vim.api.nvim_win_close(panel.win, true)
    panel.win = nil
  else
    if panel.active_tab then show_tab(panel.active_tab) end
  end
end

function M.show_terminal(opts)
  opts = opts or {}
  ensure_panel()
  if panel.collapsed then
    panel.collapsed = false
    vim.api.nvim_win_set_height(panel.win, panel.height)
  end
  panel.active_tab = 'terminal'
  local buf = panel.bufs.terminal
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_win_set_buf(panel.win, buf)
  else
    local cur_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(panel.win)
    local new_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(panel.win, new_buf)
    local job_id = vim.fn.termopen(vim.o.shell, {
      on_exit = function()
        panel.jobs.terminal = nil
        panel.bufs.terminal = nil
      end,
    })
    panel.jobs.terminal = job_id
    panel.bufs.terminal = vim.api.nvim_get_current_buf()
    if not opts.focus then vim.api.nvim_set_current_win(cur_win) end
  end
  if opts.focus then
    vim.api.nvim_set_current_win(panel.win)
    vim.cmd 'startinsert'
  end
  vim.wo[panel.win].winbar = panel_winbar()
end

-- Winbar for editor windows: shows configure/build preset + target (all clickable)
function M.winbar()
  local parts = {}
  local cfg_label = M.configure_preset or '[configure]'
  table.insert(parts, '%@v:lua.cmake_click_configure_preset@%#CMakePreset#  ' .. cfg_label .. ' %X')
  local bld_label = M.build_preset or '[build]'
  table.insert(parts, '%@v:lua.cmake_click_build_preset@%#CMakePreset#  ' .. bld_label .. ' %X')
  local target = M.last_target or '[no target]'
  table.insert(parts, '%@v:lua.cmake_click_target@%#CMakeTarget# 🎯 ' .. target .. ' %X')
  return '%=' .. table.concat(parts, '%#CMakePanelSep# │ ') .. '%*'
end

-- Highlights (Tokyo Night palette)
local function set_highlights()
  vim.api.nvim_set_hl(0, 'CMakePanelActive',   { fg = '#1a1b26', bg = '#7aa2f7', bold = true })
  vim.api.nvim_set_hl(0, 'CMakePanelInactive', { fg = '#a9b1d6', bg = '#24283b' })
  vim.api.nvim_set_hl(0, 'CMakePanelSep',      { fg = '#565f89', bg = '#24283b' })
  vim.api.nvim_set_hl(0, 'CMakePanelStop',     { fg = '#f7768e', bg = '#24283b', bold = true })
  vim.api.nvim_set_hl(0, 'CMakePanelClose',    { fg = '#f7768e', bg = '#24283b', bold = true })
  vim.api.nvim_set_hl(0, 'CMakeTarget',        { fg = '#7aa2f7', bold = true })
  vim.api.nvim_set_hl(0, 'CMakePreset',        { fg = '#bb9af7', bold = true })
end

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('CMakePanelHL', { clear = true }),
  callback = set_highlights,
})
set_highlights()

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  group = vim.api.nvim_create_augroup('CMakePanelTermInsert', { clear = true }),
  callback = function()
    if panel_is_open() and panel.active_tab == 'terminal' then
      local buf = vim.api.nvim_win_get_buf(panel.win)
      if buf == panel.bufs.terminal and vim.api.nvim_get_current_win() == panel.win then
        vim.cmd 'startinsert'
      end
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('CMakeTermKeymaps', { clear = true }),
  callback = function(args)
    local buf = args.buf
    vim.keymap.set('t', '<Esc>', '<Esc>', { buffer = buf, nowait = true })
    vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { buffer = buf, nowait = true })
  end,
})

return M
