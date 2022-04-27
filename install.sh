#!/bin/bash

###############################################################################################################
# This script is a little installer for my dotfiles, programs I use frequently, and other random stuff I need #
# DISCLAIMER: this script is NOT an installer script, it's meant to be run after a fresh install!             #
###############################################################################################################

# directory the script resides in
a="/$0"; a=${a%/*}; a=${a#/}; a=${a:-.}
currentdir=$a

if command -v apt &> /dev/null; then
	INSTALL="sudo apt install"
elif command -v pacman &> /dev/null; then
	INSTALL="sudo pacman -S"
else
	echo "Your distro is not supported."
	exit
fi

mkdir -p $HOME/.config
mkdir -p $HOME/.bin

while true
do
	echo "You can install:
	sway (w/ config)
	alacritty (w/ config)
	bash (only dotfiles)
	yay (arch only)
	ghcli (& authenticate git with github credentials)
	discord
	neovim (w/ astrovim)
	nodejs (w/ nvm)
	codenewroman"

	read -p "Enter the program name or type \"exit\": " package


	if [ $package == "exit" ]; then
		exit
	elif [ $package == "sway" ]; then
		$INSTALLCOMMAND sway

		mkdir $HOME/.config/sway
		cp $currentdir/sway/* $HOME/.config/sway
	elif [ $package == "bash" ]; then
		cp $currentdir/bash/.bashrc $HOME/.bashrc
		cp $currentdir/bash/.aliasrc $HOME/.aliasrc
	elif [ $package == "alacritty" ]; then
		cp $currentdir/alacritty/alacritty.yml $HOME/.config/alacritty/.alacritty.yml
	elif [ $package == "yay" ]; then
		pacman -S --needed git base-devel
		git clone https://aur.archlinux.org/yay-bin.git
		cd yay-bin
		makepkg -si
	elif [ $package == "ghcli" ]; then
		if command -v apt &> /dev/null; then
			curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
			echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
			sudo apt update
			$INSTALL gh
		elif command -v pacman &> /dev/null; then
			$INSTALL github-cli
		fi

		if [[ $(git config --get credential.https://github.com.helper) ]]; then
			echo "git is already authenticated with the github credentials"
		else
			gh auth login
		fi
	elif [ $package == "discord" ]; then
		if command -v apt &> /dev/null; then
			wget -O discord.deb https://discord.com/api/download?platform=linux&format=deb
			sudo dpkg -i discord.deb
			rm discord.deb
		elif command -v pacman &> /dev/null; then
			sudo pacman -S discord
		fi
	elif [ $package == "neovim" ]; then
		$INSTALL neovim

		git clone https://github.com/kabinspace/AstroVim ~/.config/nvim
		nvim +PackerSync
	elif [ $package == "codenewroman" ]; then
		wget -O CodeNewRoman.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip"
		unzip CodeNewRoman.zip -d ~/.fonts
		fc-cache -fv
		rm CodeNewRoman.zip
	elif [ $package == "nodejs" ]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
		export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

		nvm install node
	else
		echo "Option $package not found"
	fi
done
