#!/bin/bash

echo "*** Dotfiles Install Script ***"

if [ -d /usr/local/share/fonts ] && ! fc-list | grep -q "JetBrains*"; then
	echo "Downloading fonts..."
	cd /usr/local/share/fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.tar.xz
	tar -xf JetBrainsMono.tar.xz
	echo "Installing..."
	fc-cache -f
	echo "Done."
else
	echo "Directory fonts does not exist or fonts installed"
fi
