-- Detect old glibc (< 2.29) where pre-built tree-sitter-cli won't work
local function has_old_glibc()
  local handle = io.popen("ldd --version 2>&1 | head -1")
  if not handle then return false end
  local output = handle:read("*a")
  handle:close()
  local major, minor = output:match("(%d+)%.(%d+)%s*$")
  if major and minor then
    local ver = tonumber(major) + tonumber(minor) / 100
    return ver < 2.29
  end
  return false
end

local old_glibc = has_old_glibc()

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c", "cpp", "lua", "cmake", "python",
        "markdown", "markdown_inline", "vim", "vimdoc",
        "query", "bash", "json", "yaml",
      },
      auto_install = true,
    },
  },

  -- On old glibc systems (e.g. Rocky/RHEL 8), prevent Mason from installing
  -- tree-sitter-cli since the pre-built binary won't work.
  -- Use `cargo install tree-sitter-cli` and symlink to Mason's bin/ instead.
  old_glibc and {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return pkg ~= "tree-sitter-cli"
      end, opts.ensure_installed)
    end,
  } or nil,
}
