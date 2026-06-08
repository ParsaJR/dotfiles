#!/bin/bash

set -e
echo -e "*** Dotfiles Install Script ***\n"

# dependencies that need to be installed in order to use them here.
DEPS=(wget grep stow)
DOTDIR=$(dirname -- "$(realpath -- "$0")")
checkIcon="\ueab2"
errorIcon="\uea87"

# checking for existence of dependencies...
for dep in "${DEPS[@]}"; do
	if ! command -v "$dep" >/dev/null; then
		echo "$errorIcon $dep is not installed... Aborting" >&2
		exit 1
	fi
done

mkdir -p ~/.local/share/fonts
# installing nerdfonts "JetbrainsMono"
if ! fc-list | grep -q "JetBrains*"; then
	echo "Downloading fonts... Please wait"
	cd ~/.local/share/fonts
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.tar.xz
	tar -xf JetBrainsMono.tar.xz
	echo "Installing..."
	fc-cache -f
	rm JetBrainsMono.tar.xz
	echo "Done."
else
	if fc-list | grep -q "JetBrains*"; then
		echo -e "$checkIcon Fonts are installed."
	fi
fi

cd "$DOTDIR"

for package in "$DOTDIR"/*; do
	if [ -d "$package" ]; then
		stow $(basename "$package")
	fi
done

echo -e "\n$checkIcon Dotfiles are configured."
