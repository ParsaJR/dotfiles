#!/bin/bash

# Defining the URL for the Neovim Releases
NVIM_GH_URL="https://github.com/neovim/neovim/releases/latest"

# Get the latest version tag (e.g v12.0.1)
LATEST_VERSION=$(curl -s -L $NVIM_GH_URL | grep -o 'href="[^"]*' | grep -o 'releases/tag/v.*' | grep -o 'v.*')

# Path to download the nvim appimage
DOWNLOAD_LINK="https://github.com/neovim/neovim/releases/download/$LATEST_VERSION/nvim.appimage"

curl -s -L -o /usr/local/bin/nvim.appimage $DOWNLOAD_LINK
chmod +x /usr/local/bin/nvim.appimage
echo "Done!"


