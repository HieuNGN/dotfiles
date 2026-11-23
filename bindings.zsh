# =========================================================
# Keybindings (Adopted & Cleaned from Radley)
# Emacs-mode zsh with standard navigation & editing
# =========================================================

# ---------------------------------------------------------
# 1. Ctrl + Left/Right — move cursor one word
# ---------------------------------------------------------
bindkey '^[[1;5C' forward-word    # Ctrl + Right
bindkey '^[[1;5D' backward-word   # Ctrl + Left

# ---------------------------------------------------------
# 2. Ctrl + Delete — delete one word AFTER cursor
# ---------------------------------------------------------
bindkey '^[[3;5~' kill-word

# ---------------------------------------------------------
# 3. Home / End — move to beginning / end of line
# ---------------------------------------------------------
bindkey '^[[H' beginning-of-line   # Home
bindkey '^[[1~' beginning-of-line  # Home (fallback)

bindkey '^[[F' end-of-line         # End
bindkey '^[[4~' end-of-line        # End (fallback)

# ---------------------------------------------------------
# 4. Delete — remove one char AFTER cursor
# ---------------------------------------------------------
bindkey '^[[3~' delete-char        # Delete key

# ---------------------------------------------------------
# 5. Alt + Backspace — delete one word BEFORE cursor
# ---------------------------------------------------------
bindkey '^[^?' backward-kill-word  # Alt + Backspace
bindkey '^[^H' backward-kill-word  # Alt + Backspace (terminal)

# ---------------------------------------------------------
# 6. Ctrl + W — delete word before cursor (standard)
# ---------------------------------------------------------
bindkey '^W' backward-kill-word

# ---------------------------------------------------------
# 7. Ctrl + U / K — delete to start / end of line
# ---------------------------------------------------------
bindkey '^U' kill-buffer            # Ctrl + U — kill to bol
bindkey '^K' kill-line              # Ctrl + K — kill to eol

# ---------------------------------------------------------
# Radley & Fuzzy Finder
# ---------------------------------------------------------

# Ctrl+F -> fzf file picker
bindkey '^F' _fzf_file_no_hidden

# Ctrl+\ -> toggle autosuggestions
bindkey '^\\' autosuggest-toggle

# Up/Down -> history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
