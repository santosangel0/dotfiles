# ~/.bashrc

# --- 1. NON-INTERACTIVE CHECK ---
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- 2. SHELL APPEARANCE (Prompt) ---
# Format: [user@hostname current_dir]$ 
PS1='[\u@\h \W]\$ '

# --- 3. ALIASES ---
# Colorize output for standard commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Text Editor (Neovim as default)
alias vi='nvim'
alias vim='nvim'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# --- 4. FUNCTIONS ---

# lfcd: Change directory on exit from lf
# This ensures that when you quit 'lf', your shell stays in the last directory
lfcd() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Bind 'lf' to the 'lfcd' function for a seamless workflow
alias lf='lfcd'

# --- 5. ENVIRONMENT VARIABLES ---
# Ensure Neovim is the default editor for other programs
export EDITOR='nvim'
export VISUAL='nvim'
