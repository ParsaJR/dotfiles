#!/bin/bash

# Defining the URL for the Neovim Releases
NVIM_GH_URL="https://github.com/neovim/neovim/releases/latest"

# Get the latest version tag (e.g v12.0.1)
LATEST_VERSION=$(curl -s -L $NVIM_GH_URL | grep -o 'href="[^"]*' | grep -o 'releases/tag/v.*' | grep -o 'v.*')

# Get the current version installed
CURRENT_VERSION=$(nvim.appimage --version | grep -o 'NVIM .*' | grep -o 'v.*')

# Path to download the nvim appimage
DOWNLOAD_LINK="https://github.com/neovim/neovim/releases/download/$LATEST_VERSION/nvim.appimage"

echo "Current Neovim version : $CURRENT_VERSION"
echo "Latest Neovim version : $LATEST_VERSION"
read -p "Looks good? " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
	curl -s -L -o /usr/local/bin/nvim.appimage $DOWNLOAD_LINK
	chmod +x /usr/local/bin/nvim.appimage
else
	echo "Closing..."
	exit 0;
fi


echo "Done!"
