# Dotfiles

## Prerequisites

1. [FZF - Command-line fuzzy finder](https://github.com/junegunn/fzf)

## Installation

1. Clone this repo into `.dotfiles`.
2. Run `install.sh`
3. If needed, set up the wacom config manually.

## Included in this repo

### Configuration
- alacritty
- git
- i3
- lf
- neofetch
- neovim
- polybar
- tmux

### Submodules
- alacritty/themes refers to https://github.com/alacritty/alacritty-theme

### Command-line tools
- **fd** Change directory with fzf
- **fda** As above, but including hidden directories
- **fp** Change directory into predetermined shortlist of project directories

### Special guest
- wacom, contains persistent config for One by Wacom tablet I have and is not copied into ~/.config by `install.sh`
