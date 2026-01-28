#!/usr/bin/env bash

set -e 

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RS='\033[0m'

INSTALL_PATH="/usr/local/bin/algoflow"

echo -e "${BLUE}[Installing]${RS} AlgoFlow..."

if [[ ! -f "AlgoFlow.sh" ]]; then
    echo -e "Error: AlgoFlow.sh not found in current directory."
    exit 1
fi

sudo cp AlgoFlow.sh "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

echo -e "${GREEN}[Success]${RS} AlgoFlow installed to $INSTALL_PATH"
echo -e "Try typing '${BLUE}algoflow${RS}' to start!"
