#!/usr/bin/env sh

# This script assumes that an unpriviledged user with sudo has been added and we're logged in as that user

# if whoami returns root or sudo isn't installed, exit
if [[ $(whoami) == "root" ]]; then
	echo "This script must be run as an unpriviledged user with sudo access"
	exit 1
fi

# if there's no sudo also exit, you're probably on alpine linux and you haven't finished setting up the basics yet
if [[ ! -x "$(command -v sudo)" ]]; then
	echo "This script requires sudo to be installed"
	exit 1
fi

# Several steps in this script require root access, so let's get the user authenticated first.
echo "Several steps in this script require root access."
sudo echo "Authenticated."

# Two possibilities exist: Either we're on macOS, or we're on Linux.
# If we're on macOS, we can use Homebrew to install the necessary packages.
# If Linux, check if we're using Arch ( btw ), Alpine, or a debian-based distro and use the appropriate package manager.

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

elif [[ -f /etc/arch-release ]]; then # Check if we're running Arch Linux

	echo "Looks like we're running Arch (btw)"
	echo "Performing an update first"
	sudo pacman -Syu

	echo "Installing necessary packages using pacman"
	sudo pacman -S zsh neovim tmux go nvm pnpm fzf ripgrep ffmpeg nmap htop mongodb-database-tools parallel tree watch stow

elif [[ -f /etc/alpine-release ]]; then # Check if we're running Alpine Linux

	echo "We're running Alpine"
	echo "Performing an update first"
	sudo apk update
	
	echo "Installing necessary packages using apk"
	sudo apk add zsh
	sudo apk add chsh
	sudo apk add git
	sudo apk add curl
	sudo apk add gcc
	sudo apk add neovim
	sudo apk add tmux
	sudo apk add golang
	sudo apk add nvm
	sudo apk add pnpm
	sudo apk add fzf
	sudo apk add ripgrep
	sudo apk add ffmpeg
	sudo apk add nmap
	sudo apk add htop
	sudo apk add parallel
	sudo apk add tree
	sudo apk add watch
	sudo apk add stow

elif [[ -f /etc/debian_version ]]; then # Check if we're running a debian-based distro

	echo "Detected Debian"
	echo "Performing an update first"
	sudo apt update
	echo "Installing necessary packages using apt"
	sudo apt install zsh neovim tmux golang nvm pnpm fzf ripgrep ffmpeg nmap htop mongodb-database-tools parallel tree watch stow

fi

# Set zsh as the default shell
echo "Setting zsh as the default shell"
chsh -s $(which zsh)

# - Clone packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Packages are all set up, run stow
echo "Running stow"
cd "$(dirname "$0")"
stow .

# TODO: INSTALL VIM PLUGINS
# TODO: INSTALL VIM LSPs

# Oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
	echo "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


return 0
