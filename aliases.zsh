# Better ls
alias ls='eza --icons'

# Detailed listing
alias ll='eza -lh --icons --git'

# Detailed listing including hidden files
alias la='eza -lah --icons --git'

# Tree view
alias tree='eza --tree --icons'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# =========================================================
# Editor
# =========================================================

alias vim='nvim'

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# =========================================================
# Hieu's Lab & System Aliases
# =========================================================
alias remove="sudo dnf remove"
alias install="sudo dnf install -y"
alias reboot="sudo systemctl reboot"
alias shutdown="sudo systemctl poweroff"

# net tools
alias ports="sudo netstat -tulanp"
alias myip="curl ifconfig.me"

# python
alias py="python"
alias pya="python3"
alias ca="conda activate"
alias cda="conda deactivate"
alias ce="conda env list"
alias cj="conda install"
alias please="sudo"
alias cls="clear"
alias reload="source ~/.config/zsh/.zshrc"

# scripts
alias update="cd ~/scripts/ && sudo ./fedora-kde-update.sh"
alias clean="cd ~/scripts/ && sudo ./clean.sh"
alias pgrs="sudo su - postgres"

# Git stuff
alias ga="git add"
alias gc="git commit"
alias gp="git push"

# System manipulation
alias sc="systemctl"
alias scu="systemctl --user"

# Service management
alias scstart='sudo systemctl start'
alias scstop='sudo systemctl stop'
alias screstart='sudo systemctl restart'
alias screload='sudo systemctl reload'

# Monitoring & Configuration
alias scstatus='systemctl status'
alias scele='sudo systemctl enable'
alias scdis='sudo systemctl disable'
alias scdr='sudo systemctl daemon-reload'
alias sclu='systemctl list-units'
alias scmask='sudo systemctl mask'

# hermes
alias hdash="hermes dashboard"
alias hset="hermes setup"
alias hmod="hermes model"
alias hconf="hermes config"
