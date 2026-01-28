#!/usr/bin/env bash

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RS='\033[0m'

SOURCE_URL="https://raw.githubusercontent.com/xiechunyao/AlgoFlow/main/AlgoFlow.sh"
TARGET_PATH="/usr/local/bin/algoflow"

echo -e "${BLUE}[Downloading]${RS} AlgoFlow..."

curl -sSL "$SOURCE_URL" -o /tmp/algoflow

if [[ $? -ne 0 ]]; then
    echo "Download failed! Please check your internet connection."
    exit 1
fi

echo -e "${BLUE}[Installing]${RS} Installing to $TARGET_PATH..."
sudo mv /tmp/algoflow "$TARGET_PATH"
sudo chmod +x "$TARGET_PATH"

echo -e "${GREEN}[Success]${RS} AlgoFlow installed to $TARGET_PATH successfully"
echo -e "Try typing '${BLUE}algoflow${RS}' to start!"
