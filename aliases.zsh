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
# bat is `batcat` on Debian; fall back to nothing if neither exists
if (( $+commands[bat] )); then
    alias cat='bat'
elif (( $+commands[batcat] )); then
    alias cat='batcat'
fi

# =========================================================
# Core utilities
# =========================================================

# alias g='rg'
alias diff='diff --color=auto'
alias df='df -h'
alias power='watch -n 1 "awk '\''{printf \"Idle Power: %.2f W\n\", \$1/1000000}'\'' /sys/class/power_supply/BAT*/power_now 2>/dev/null"'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

if (( $+commands[lf] )); then
    lf() { # zsh follow lf navigation
        tmp=$(mktemp)
        command lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
            dir=$(cat "$tmp")
            rm -f "$tmp"
            [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        fi
    }
fi

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
# Package manager specific install/remove
if [ -f /etc/fedora-release ]; then
    alias install='sudo dnf install -y'
    alias remove='sudo dnf remove'
elif [ -f /etc/debian_version ]; then
    alias install='sudo apt install -y'
    alias remove='sudo apt remove'
elif [ -f /etc/arch-release ]; then
    alias install='sudo pacman -S --noconfirm'
    alias remove='sudo pacman -R'
elif [ "$(uname)" = "Darwin" ]; then
    alias install='brew install'
    alias remove='brew uninstall'
fi
alias reboot="sudo systemctl reboot"
alias shutdown="sudo systemctl poweroff"
alias sleeep="sc suspend"

# net tools
alias ports="sudo netstat -tulanp"
alias myip="curl ifconfig.me"

# python
alias py="python"
alias pya="python3"
if (( $+commands[conda] )); then
    alias ca="conda activate"
    alias cda="conda deactivate"
    alias ce="conda env list"
    alias cj="conda install"
fi
alias please="sudo"
alias cls="clear"
alias reload="source ~/.config/zsh/.zshrc"

# scripts
if [ -f /etc/fedora-release ]; then
    # Fedora: only if the helper scripts are actually present
    [ -f "$HOME/scripts/fedora-kde-update.sh" ] && alias update="cd ~/scripts/ && sudo ./fedora-kde-update.sh"
    [ -f "$HOME/scripts/clean.sh" ] && alias clean="cd ~/scripts/ && sudo ./clean.sh"
elif [ -f /etc/debian_version ]; then
    alias update='sudo apt update && sudo apt full-upgrade -y'
    alias clean='sudo apt autoremove -y && sudo apt autoclean'
fi
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
alias scumask='sudo systemctl unmask'

#ssh quick commands
alias lrig="ssh root@10.0.20.100"
alias lm920s="ssh tiny-rig@10.0.10.95"
# alias lcele="ssh srv-ubuntu@10.0.0.110"

#ssh remote
#alias rrig="ssh root@100.77.20.23"
alias rm920s="ssh tiny-rig@100.87.61.25"
alias rxeon="ssh ras@100.120.178.100"
#alias rcele="ssh srv-ubuntu@100.122.144.7"

# Wake-on-LAN (local LAN) — wol CLI (replaces python ~/bin/wol)
alias wol-m920s="wol -h 10.0.10.255 00:23:24:5d:a1:86"
alias wol-amdrig="wol -h 10.0.20.100 9c:6b:00:d2:43:c4"  # directed unicast — works from VLAN 10 (static ARP + fwd rule)

# Wake-on-LAN (remote via Tailscale → rwormhoe → wakeonlan on LAN)
alias rwol-amdrig="ssh rwormhoe 'wakeonlan -i 10.0.20.100 -p 9 9C:6B:00:D2:43:C4'"
# hermes
alias hdash="hermes dashboard"
alias hset="hermes setup"
alias hmod="hermes model"
alias hconf="hermes config"

#tailscale exit node
alias tail-noexit='sudo tailscale set --exit-node='
alias tail-exit="sudo tailscale set --exit-node=worm-hoe --exit-node-allow-lan-access=true"

#tailscale LAN toggle: home desk vs roam — subnet routes hijack LAN IPs via rule 5270
alias tail-lan="sudo tailscale set --accept-routes=false && tailscale ping -c 1 worm-hoe"
alias tail-roam="sudo tailscale set --accept-routes=true"
alias tail-routes="tailscale debug prefs | grep RouteAll; ip route get 10.0.10.95 | head -1"
