#!/bin/bash

###############################################################################################################
# This script is a little installer for my dotfiles, programs I use frequently, and other random stuff I need #
# DISCLAIMER: this script is NOT an OS installer script, it's meant to be run after a fresh install!          #
###############################################################################################################

# directory the script resides in
a="/$0"; a=${a%/*}; a=${a#/}; a=${a:-.}
currentdir=$a

if command -v apt &> /dev/null; then
	INSTALL="sudo apt install"
	echo "Warning: Debian based distros are not fully tested. Proceed with caution."
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
	sway/desktop/rice - my sway desktop w/ config, rofi, alacritty, neovim (astrovim), bash dotfiles, xsettingsd, codenewroman font and gtk theme
	yay - arch only
	ghcli - automatically runs gh auth login
	discord
	nodejs - installed using nvm"

	read -p "Enter the program name or type \"exit\": " package


	if [ $package == "exit" ]; then
		exit
	elif [ $package == "sway" ] || [ $package == "desktop" ] || [ $package == "rice" ]; then
		$INSTALLCOMMAND sway rofi xsettingsd xorg-xwayland alacritty neovim unzip

		wget -O CodeNewRoman.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip"
		unzip CodeNewRoman.zip -d ~/.fonts
		fc-cache -fv
		rm CodeNewRoman.zip

		mkdir $HOME/.config/sway
		mkdir $HOME/.config/rofi
		mkdir $HOME/.config/xsettingsd
		mkdir $HOME/.config/alacritty
		mkdir $HOME/.themes

		cp $currentdir/sway/* $HOME/.config/sway
		cp $currentdir/rofi/* $HOME/.config/rofi
		cp $currentdir/xsettingsd/* $HOME/.config/xsettingsd
		cp $currentdir/themes/Adwaita-One-Dark $HOME/.themes
		cp $currentdir/alacritty/alacritty.yml $HOME/.config/alacritty/.alacritty.yml
		cp $currentdir/bash/.bashrc $HOME/.bashrc
		cp $currentdir/bash/.aliasrc $HOME/.aliasrc

		git clone https://github.com/kabinspace/AstroVim ~/.config/nvim
		nvim +PackerSync
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
	elif [ $package == "nodejs" ]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
		export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

		nvm install node
	else
		echo "Option $package not found"
	fi
done
