#!/bin/bash
# Run on any machine. Backs up existing configs first.
set -e

SOURCE="$HOME/projs/dotfiles"
ZDOTDIR="$HOME/.config/zsh"

# Backup function
backup() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        mv "$1" "$1.bak.$(date +%s)"
        echo "  Backed up $1"
    fi
}

echo "=== ZSH Dotfiles Installer ==="
echo "Source: $SOURCE"
echo "Target: $ZDOTDIR"
echo ""

# Verify source
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: $SOURCE not found. Clone repo first."
    exit 1
fi

# Create ZDOTDIR
mkdir -p "$ZDOTDIR"
mkdir -p "$HOME/.local/state/zsh"
mkdir -p "$HOME/.cache/zsh"

# Entry point (at $HOME, not $ZDOTDIR)
echo "→ Symlinking ~/.zshenv"
backup "$HOME/.zshenv"
ln -sf "$SOURCE/.zshenv" "$HOME/.zshenv"

# Modular configs
FILES=(.zshrc aliases.zsh bindings.zsh fzf.zsh plugins.zsh prompt.zsh starship.toml zshenv.zsh)
for f in "${FILES[@]}"; do
    echo "→ Symlinking $ZDOTDIR/$f"
    backup "$ZDOTDIR/$f"
    ln -sf "$SOURCE/$f" "$ZDOTDIR/$f"
done

# Plugins — clone fresh (not symlinked)
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

echo ""
echo "=== Done ==="
echo "Restart shell: exec zsh"
echo ""
echo "Verify:"
echo "  ls -la ~/.zshenv"
echo "  ls -la ~/.config/zsh/"
