# ~/.bashrc - Custom Termux configurations
# Written by: Mikael Todd
# Purpose: Enhance productivity, uncomplicate Termux, and improve shell appearance

########################
# SAFETY & ENVIRONMENT #
########################

# Bash safety options
set -o errexit      # Exit on command error
set -o pipefail     # Catch pipe errors
# 'nounset' is disabled for interactive shell to avoid crashes
case $- in
    *i*) ;;         # interactive shell
    *) set -o nounset ;;
esac

# Basic PATH and editor setup
export EDITOR="nano"
export VISUAL="nano"
export PAGER="less"
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=5000
export HISTCONTROL=ignoredups:erasedups
export PATH="$HOME/.local/bin:$PATH"

# Create local bin if missing
mkdir -p "$HOME/.local/bin"

####################
# PROMPT & COLORS  #
####################

# Color support for ls and others
if [ -x /data/data/com.termux/files/usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
fi

# PS1 prompt customization
cyan='\[\e[0;36m\]'
green='\[\e[0;32m\]'
yellow='\[\e[0;33m\]'
reset='\[\e[0m\]'
export PS1="${green}\u${reset}@${cyan}\h${reset}:${yellow}\w${reset}\$ "

####################
# COMMON ALIASES   #
####################

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lhF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias cls='clear && printf "\033c"'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias h='history'
alias e='exit'
alias vi='nvim'
alias nano='nano -c'
alias update='pkg update -y && pkg upgrade -y && apt autoremove -y && apt clean'

# Git shortcuts
alias gs='git status'
alias gp='git pull'
alias gc='git commit -m'
alias ga='git add .'
alias gpush='git push'

# System shortcuts
alias termux-fix-permissions='termux-setup-storage'
alias restart-termux='kill -9 $(pidof com.termux)'

####################
# HELPER FUNCTIONS #
####################

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.7z)      7z x "$1" ;;
            *) echo "Unsupported archive type: $1" ;;
        esac
    else
        echo "Usage: extract <archive>"
    fi
}

# Show local and external IPs using ifconfig
myip() {
    # Find the first non-loopback IPv4 address
    local local_ip
    local_ip=$(ifconfig 2>/dev/null | awk '
        $1 ~ /^[a-zA-Z0-9]/ { iface=$1 }
        $1 == "inet" && $2 != "127.0.0.1" { print $2; exit }
    ')
    echo "Local IP: ${local_ip:-Not found}"
    echo "External IP: $(curl -s ifconfig.me)"
}

sysinfo() {
    echo "==== System Info ===="
    termux-info 2>/dev/null || echo "termux-info not available"
    echo "====================="
    echo "Uptime: $(uptime -p)"
    echo "Memory: $(free -h | awk '/Mem/{print $3 \"/\" $2}')"
    echo "Disk: $(df -h /data | awk 'NR==2{print $3 \"/\" $2}')"
}

serve() {
    local port="${1:-8000}"
    echo "Starting HTTP server on port $port..."
    python -m http.server "$port"
}

###################
# CUSTOM GREETING #
###################

if [ -z "${TERMUX_BASHRC_LOADED:-}" ]; then
    export TERMUX_BASHRC_LOADED=1
    clear
    echo -e "${cyan}Welcome back, ${green}morteck${reset}!"
    echo -e "Device: ${cyan}$(uname -o) $(uname -m)${reset}"
    echo -e "Date:   ${yellow}$(date)${reset}\n"
fi

###################
# END OF FILE     #
###################

# Copyright (c) 2025 Mikael Todd
# Licensed under the MIT License. See LICENSE file for details.
