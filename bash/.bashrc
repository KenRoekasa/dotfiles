# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
	PS1="\[\e[31m\]\u\[\e[m\]\[\e[31m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]:\w\\$ "
then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
	PS1="\[\e[34m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\w\\$ "

fi
export PATH
export PS1
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias clion='clion.sh'
alias cd_code='cd ~/arbareus'
alias build_all='cd_code && ./bb build_all'
alias commit_pipeline='cd_code && ./bb commit_pipeline'
alias database='mysql -u root'
alias distcc_status='watch -n 0.1 distccmon-text'
alias ip_snoop='sudo tcpdump -s0 -nn -A -i any host'
alias arb_acceptance_ui='cd_code && cd cmake-build-debug && ./ArbWatchdog -c ../extra/ArbWatchdog/config/KennyAcceptance.conf'
alias start_sql='sudo service mysqld start'
alias stop_sql='sudo service mysqld stop'
alias restart_sql='sudo service mysqld restart'
alias vpn="globalprotect connect -p globalprotect.lmax.com -u roekasak"
export PATH=":~/Downloads/CLion-2023.1.3/clion-2023.1.3/bin:$PATH"
alias python="python3"
export TMPDIR="/home/roekasak/tmp"
alias ll="ls -l"
alias killBuild="ps faux | grep roekasak |  grep cc1 | awk {'print \$2'} | xargs kill -9"


export DSL_BIND_IP="127.0.0.7"
export PATH="~/Downloads/squashfs-root/usr/bin:$PATH"
export PATH=":$PATH:~/Downloads/lazygit_0.53.0_Linux_x86_64"
export PATH=":$PATH:~/.nvm/versions/node/v22.18.0/bin/node"

source ~/arbareus/bb.autocomplete
source ~/arbareus/dev.autocomplete


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
