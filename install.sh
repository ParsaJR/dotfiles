#!/bin/bash

echo "*** Dotfiles Install Script ***"


DEPS=(wget grep stow)

for dep in "${DEPS[@]}"; do
	if ! command -v "$dep" > /dev/null; then
		echo "$dep is not installed... Aborting" >&2
		exit 1
	fi 
done

if [ -d /usr/local/share/fonts ] && ! fc-list | grep -q "JetBrains*"; then
	echo "Downloading fonts... Please wait"
	cd /usr/local/share/fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.tar.xz
	tar -xf JetBrainsMono.tar.xz
	echo "Installing..."
	fc-cache -f
	echo "Done."
else
	if fc-list | grep -q "JetBrains*"; then
	echo "fonts are installed"
	else
		echo "Directory font does not exist!"
	fi
fi
