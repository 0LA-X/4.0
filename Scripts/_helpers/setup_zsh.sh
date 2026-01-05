#!/usr/bin/env bash

set -e

DOT_DIR="$HOME/4.0"

echo "  Starting Zsh + Plugin + Starship setup on Arch Linux..."

# Check yay installation
if ! command -v yay &> /dev/null; then
    echo "  'yay' is not installed. Please install yay first."
    exit 1
fi

# Check and install Zsh if needed
if ! command -v zsh &> /dev/null; then
    echo "  Zsh not found. Installing Zsh..."
    yay -S --noconfirm zsh
fi

# Set Zsh as default shell if not already
CURRENT_SHELL="$(basename "$SHELL")"
if [[ "$CURRENT_SHELL" != "zsh" ]]; then
    echo "  Setting Zsh as the default shell for user: $USER"
    chsh -s "$(command -v zsh)"
else
    echo "  Zsh is already the default shell."
fi

# ---- Dotfiles via Stow ----
if [[ -d "$DOT_DIR" ]]; then
    echo "📁  Found dotfiles directory: $DOT_DIR"
    cd "$DOT_DIR"

    if command -v stow &> /dev/null; then
        echo "🔗  Stowing Zsh config..."
        stow zsh
    else
        echo "  GNU Stow is not installed. Install it with:"
        echo "    yay -S stow"
        exit 1
    fi
else
    echo "  Dotfiles directory not found: $DOT_DIR"
    echo "    Skipping stow step."
fi

echo "  All components installed! Restart your terminal to apply changes."
