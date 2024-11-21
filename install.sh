#!/usr/bin/env zsh

# Several steps in this script require root access, so let's get the user authenticated first.
echo "Several steps in this script require root access."
sudo echo "Authenticated."

# Oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
	echo "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# Once oh-my-zsh is installed, remove .zshrc so stow can symlink the correct one
	rm ~/.zshrc
fi

# Two possibilities exist: Either we're on macOS, or we're on Linux.
# If we're on macOS, we can use Homebrew to install the necessary packages.
# If Linux, check if we're using Arch ( btw ), Alpine, or a debian-based distro.

# Check which OS we're running and install the necessary packages
if [[ "$OSTYPE" == "darwin"* ]]; then
	echo "Looks like we're running macOS"

	# Install homebrew if it's not already installed
	if [[ ! -x "$(command -v brew)" ]]; then
		echo "Installing Homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	# Install necessary packages using Homebrew
	brew install zsh neovim tmux golang nvm pnpm fzf ripgrep ffmpeg nmap htop mongodb-database-tools parallel tree watch stow

elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	echo "Looks like we're running Linux"

	# Check if we're running Arch Linux
	if [[ -f /etc/arch-release ]]; then
		echo "In fact it's Arch (btw)"
		echo "Performing an update first"
		sudo pacman -Syu
		echo "Installing necessary packages using pacman"
		sudo pacman -S zsh neovim tmux go nvm pnpm fzf ripgrep ffmpeg nmap htop mongodb-database-tools parallel tree watch stow
	fi

	# Check if we're running Alpine Linux
	if [[ -f /etc/alpine-release ]]; then
		echo "In fact it's Alpine"
		echo "Performing an update first"
		sudo apk update
		echo "Installing necessary packages using apk"
		sudo apk add zsh neovim tmux golang nvm pnpm fzf ripgrep ffmpeg nmap htop mongodb-database-tools parallel tree watch stow

	fi

	# Check if we're running a debian-based distro
	# This includes Ubuntu, Debian, and Pop!_OS
	if [[ -f /etc/debian_version ]]; then
		echo "In fact it's a debian-based distro"
		echo "Performing an update first"
		sudo apt update
		echo "Installing necessary packages using apt"
		sudo apt install zsh neovim tmux golang nvm pnpm fzf ripgrep ffmpeg nmap htop mongodb-database-tools parallel tree watch stow
	fi
fi

return 0

# # Set zsh as the default shell
# echo "Setting zsh as the default shell"
# chsh -s $(which zsh)

# # Packages are all set up, run stow
# echo "Running stow"
# cd "$(dirname "$0")"
# stow .

# TODO:
# - Install packer
# - Install vim plugins
# - Set zsh as the default shell
#
