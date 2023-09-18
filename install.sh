#!/bin/zsh

# If they exist, back up existing dotfile directories
mv ~/.config/alacritty ~/.config/alacritty.bak 2>/dev/null || true
mv ~/.config/i3 ~/.config/i3.bak 2>/dev/null || true
mv ~/.config/lf ~/.config/lf.bak 2>/dev/null || true
mv ~/.config/neofetch ~/.config/neofetch.bak 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
mv ~/.config/polybar ~/.config/polybar.bak 2>/dev/null || true
mv ~/.config/tmux ~/.config/tmux.bak 2>/dev/null || true

# Create symlinks to dotfiles
ln -s -n ~/.dotfiles/alacritty ~/.config/alacritty
ln -s -n ~/.dotfiles/i3 ~/.config/i3
ln -s -n ~/.dotfiles/lf ~/.config/lf
ln -s -n ~/.dotfiles/neofetch ~/.config/neofetch
ln -s -n ~/.dotfiles/nvim ~/.config/nvim
ln -s -n ~/.dotfiles/polybar ~/.config/polybar
ln -s -n ~/.dotfiles/tmux ~/.config/tmux

