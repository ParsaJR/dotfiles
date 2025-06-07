#!/bin/bash

# Defining the URL for the Neovim Releases
NVIM_GH_URL="https://github.com/neovim/neovim/releases/latest"

# Get the latest version tag (e.g v12.0.1)
LATEST_VERSION=$(curl -s -L $NVIM_GH_URL | grep -o 'href="[^"]*' | grep -o 'releases/tag/v.*' | grep -o 'v.*')

# Get the current version installed
CURRENT_VERSION=$(nvim --version | grep -o 'NVIM .*' | grep -o 'v.*')

# Path to download the nvim appimage
DOWNLOAD_LINK="https://github.com/neovim/neovim/releases/download/$LATEST_VERSION/nvim-linux-x86_64.tar.gz"

echo "Your Current Neovim version: $CURRENT_VERSION"
echo "The Latest Neovim version on Github: $LATEST_VERSION"
read -p "Looks good? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -s -L -o nvim-linux-x86_64.tar.gz $DOWNLOAD_LINK
	tar -xzf nvim-linux-x86_64.tar.gz
	cd nvim-linux-x86_64/
	sudo cp -R bin share lib /usr
else
	echo "Closing..."
	exit 0;
fi


rm -R ../nvim-linux-x86_64
rm ../nvim-linux-x86_64.tar.gz

echo "Done!"
