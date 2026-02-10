#!/usr/bin/env bash

# color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RS='\033[0m'

# config
INSTALL_DIR="/opt/algoflow"
BIN_PATH="/usr/local/bin/algoflow"

echo -e "${RED}[Uninstalling]${RS} AlgoFlow from your system..."

# removing symlink
if [[ -L "$BIN_PATH" || -f "$BIN_PATH" ]]; then
    echo -e "${BLUE}[1/2]${RS} Removing executable link: $BIN_PATH"
    sudo rm "$BIN_PATH"
fi

# removing main program
if [[ -d "$INSTALL_DIR" ]]; then
    echo -e "${BLUE}[2/2]${RS} Removing program files: $INSTALL_DIR"
    sudo rm -rf "$INSTALL_DIR"
fi

# output
if [[ ! -d "$INSTALL_DIR" && ! -f "$BIN_PATH" ]]; then
    echo -e "${GREEN}[Success]${RS} AlgoFlow has been completely removed."
else
    echo -e "${RED}[ERROR]${RS} Some files could not be removed. Please check permissions."
fi
