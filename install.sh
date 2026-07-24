#!/bin/bash
# ZSH dotfiles installer — symlinks configs from ~/projs/dotfiles/ (Option B)
# Detects OS, adapts paths and dependencies. Run on any machine.
set -e

SOURCE="$HOME/projs/dotfiles"
ZDOTDIR="$HOME/.config/zsh"

# ─── OS Detection ──────────────────────────────────────────────
OS="unknown"
PKG_MGR=""
INSTALL_CMD=""

detect_os() {
    if [ -f /etc/fedora-release ]; then
        OS="fedora"
        PKG_MGR="dnf"
        INSTALL_CMD="sudo dnf install -y"
    elif [ -f /etc/debian_version ]; then
        OS="debian"
        PKG_MGR="apt"
        INSTALL_CMD="sudo apt install -y"
    elif [ -f /etc/arch-release ]; then
        OS="arch"
        PKG_MGR="pacman"
        INSTALL_CMD="sudo pacman -S --noconfirm"
    elif [ "$(uname)" = "Darwin" ]; then
        OS="macos"
        PKG_MGR="brew"
        INSTALL_CMD="brew install"
    else
        OS="unknown"
    fi
}

detect_os

echo "=== ZSH Dotfiles Installer ==="
echo "Source:    $SOURCE"
echo "Target:    $ZDOTDIR"
echo "OS:        $OS"
echo "Pkg mgr:   $PKG_MGR"
echo ""

# Verify source
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: $SOURCE not found. Clone repo first:"
    echo "  git clone <remote> $SOURCE"
    exit 1
fi

# Verify zsh is installed
if ! command -v zsh &>/dev/null; then
    echo "→ zsh not found. Installing..."
    case "$OS" in
        fedora)   $INSTALL_CMD zsh ;;
        debian)   $INSTALL_CMD zsh ;;
        arch)     $INSTALL_CMD zsh ;;
        macos)    $INSTALL_CMD zsh ;;
        *)
            echo "ERROR: Cannot auto-install zsh on $OS. Install manually."
            exit 1
            ;;
    esac
fi

echo "→ zsh: $(zsh --version | head -1)"

# ─── Backup function ───────────────────────────────────────────
backup() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        mv "$1" "$1.bak.$(date +%s)"
        echo "  Backed up $1"
    fi
}

# ─── Create directories ────────────────────────────────────────
mkdir -p "$ZDOTDIR"
mkdir -p "$HOME/.local/state/zsh"
mkdir -p "$HOME/.cache/zsh"

# ─── Symlink configs ───────────────────────────────────────────
echo ""
echo "→ Symlinking configs..."

# Entry point (at $HOME, not $ZDOTDIR)
backup "$HOME/.zshenv"
ln -sf "$SOURCE/.zshenv" "$HOME/.zshenv"

# Modular configs
FILES=(.zshrc aliases.zsh bindings.zsh fzf.zsh plugins.zsh prompt.zsh starship.toml zshenv.zsh)
for f in "${FILES[@]}"; do
    backup "$ZDOTDIR/$f"
    ln -sf "$SOURCE/$f" "$ZDOTDIR/$f"
done

# ─── Per-machine zshenv.zsh override ───────────────────────────
# If a machine-specific zshenv exists in repo, use it instead
MACHINE_ZSHENV="$SOURCE/hosts/$(hostname)/zshenv.zsh"
if [ -f "$MACHINE_ZSHENV" ]; then
    echo "  → Found host-specific zshenv.zsh for $(hostname)"
    ln -sf "$MACHINE_ZSHENV" "$ZDOTDIR/zshenv.zsh"
fi

echo "  Done."

# ─── Install dependencies ──────────────────────────────────────
echo ""
echo "→ Checking dependencies..."

check_and_install() {
    local cmd="$1" pkg="$2"
    if command -v "$cmd" &>/dev/null; then
        echo "  ✓ $cmd: $(command -v $cmd)"
    else
        echo "  ✗ $cmd not found. Installing $pkg..."
        if [ "$OS" = "macos" ]; then
            $INSTALL_CMD "$pkg" 2>/dev/null || echo "    (install failed — install manually)"
        elif [ "$OS" != "unknown" ]; then
            $INSTALL_CMD "$pkg" 2>/dev/null || echo "    (install failed — install manually)"
        else
            echo "    Cannot auto-install on $OS"
        fi
    fi
}

case "$OS" in
    fedora)
        check_and_install eza eza
        check_and_install bat bat
        check_and_install rg ripgrep
        check_and_install fd fd-find
        check_and_install fzf fzf
        check_and_install zoxide zoxide
        check_and_install starship starship
        ;;
    debian)
        check_and_install eza eza
        check_and_install bat bat
        check_and_install rg ripgrep
        check_and_install fd-find fd-find
        check_and_install fzf fzf
        check_and_install zoxide zoxide
        check_and_install starship starship
        ;;
    arch)
        check_and_install eza eza
        check_and_install bat bat
        check_and_install rg ripgrep
        check_and_install fd fd
        check_and_install fzf fzf
        check_and_install zoxide zoxide
        check_and_install starship starship
        ;;
    macos)
        check_and_install eza eza
        check_and_install bat bat
        check_and_install rg ripgrep
        check_and_install fd fd
        check_and_install fzf fzf
        check_and_install zoxide zoxide
        check_and_install starship starship
        ;;
    *)
        echo "  Unknown OS — skipping dependency install"
        echo "  Install manually: eza bat ripgrep fd fzf zoxide starship"
        ;;
esac

# ─── Plugins — clone fresh (not symlinked) ────────────────────
echo ""
echo "→ Cloning plugins..."
mkdir -p "$ZDOTDIR/plugins"

clone_plugin() {
    local name="$1" url="$2"
    if [ ! -d "$ZDOTDIR/plugins/$name" ]; then
        git clone --depth 1 "$url" "$ZDOTDIR/plugins/$name" 2>/dev/null && echo "  ✓ $name" || echo "  ✗ $name (failed)"
    else
        echo "  ⊙ $name (exists)"
    fi
}

clone_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
clone_plugin "zsh-history-substring-search" "https://github.com/zsh-users/zsh-history-substring-search"
clone_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continued/fast-syntax-highlighting"

# ─── Set default shell ────────────────────────────────────────
echo ""
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "→ Current shell: $SHELL"
    echo "  Change default shell to zsh?"
    read -p "  [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chsh -s "$(command -v zsh)"
        echo "  ✓ Default shell changed. Logout/login to apply."
    else
        echo "  Skipped. Run manually: chsh -s $(command -v zsh)"
    fi
else
    echo "→ Default shell already zsh ✓"
fi

# ─── Summary ───────────────────────────────────────────────────
echo ""
echo "=== Done ==="
echo "OS:        $OS"
echo "Source:    $SOURCE"
echo "ZDOTDIR:   $ZDOTDIR"
echo ""
echo "Restart shell: exec zsh"
echo ""
echo "Verify:"
echo "  ls -la ~/.zshenv"
echo "  ls -la ~/.config/zsh/"