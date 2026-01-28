#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
RS='\033[0m'

INSTALL_PATH="/usr/local/bin/algoflow"

echo -e "${RED}[Uninstalling]${RS} AlgoFlow..."

if [[ -f "$INSTALL_PATH" ]]; then
    sudo rm "$INSTALL_PATH"
    echo -e "${GREEN}[Success]${RS} AlgoFlow has been removed."
else
    echo -e "AlgoFlow is not installed in $INSTALL_PATH."
fi
