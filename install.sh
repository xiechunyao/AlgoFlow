#!/usr/bin/env bash

# color
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
RS='\033[0m'

# config
REPO_URL="https://github.com/xiechunyao/AlgoFlow.git"
INSTALL_DIR="/opt/algoflow"
BIN_PATH="/usr/local/bin/algoflow"
CONFIG_DIR="$HOME/.config/algoflow"
TEMPLATES_DIR="$HOME/.config/algoflow/templates"

echo -e "${BLUE}[Installing]${RS} Preparing to install AlgoFlow..."

# checking old version
if [[ -d "$INSTALL_DIR" ]]; then
    echo -e "${BLUE}[Info]${RS} Removing old version..."
    sudo rm -rf "$INSTALL_DIR"
fi

# clone
echo -e "${BLUE}[Downloading]${RS} Cloning repository from GitHub..."
sudo git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"

if [[ $? -ne 0 ]]; then
    echo -e "${RED}[ERROR]${RS} Clone failed! Please check git installation and network."
    exit 1
fi

# checking config
if [[ ! -d "$CONFIG_DIR" ]]; then
    sudo mkdir "$CONFIG_DIR"
    sudo mv "$INSTALL_DIR/templates" "$CONFIG_DIR"
    echo -e "${BLUE}[Info]${RS} Creating config directory..."
fi

sudo chmod +x "$INSTALL_DIR/AlgoFlow.sh"

# creating symlink and moving
echo -e "${BLUE}[Linking]${RS} Creating symbolic link to $BIN_PATH..."
sudo ln -sf "$INSTALL_DIR/AlgoFlow.sh" "$BIN_PATH"

# output
echo -e "-----------------------------------------------"
echo -e "${GREEN}[Success]${RS} AlgoFlow installed successfully!"
echo -e "${BLUE}Location:${RS} $INSTALL_DIR"
echo -e "${BLUE}Config Location:${RS} $CONFIG_DIR"
echo -e "${BLUE}Command:${RS}  $BIN_PATH"
echo -e "-----------------------------------------------"
echo -e "Try typing '${BLUE}algoflow${RS}' to start!"
