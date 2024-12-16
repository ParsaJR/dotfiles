#!/bin/bash

echo "*** Dotfiles Install Script ***"

# dependencies that need to be installed in order to use them here.
DEPS=(wget grep stow)
DOTDIR=$(dirname -- "$(realpath -- "$0")")

# checking for existence of dependencies...
for dep in "${DEPS[@]}"; do
	if ! command -v "$dep" > /dev/null; then
		echo "$dep is not installed... Aborting" >&2
		exit 1
	fi 
done

# installing nerdfonts "JetbrainsMono"
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

cd "$DOTDIR"

for package in "$DOTDIR"/*; do
	if [ -d "$package" ]; then
		stow "$package"
	fi
done
