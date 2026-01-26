#!/bin/bash

# --config--
AUTHOR="chunyao"
LANGUAGE="cpp"
set -eu

# --color constants--
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
# reset color
RS='\033[0m'

# --fuctions--
log_info() { echo -e "${BLUE}[INFO]${RS} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${RS} $1"; }
log_error() { echo -e "${RED}[ERROR]${RS} $1"; }

show_help() {
  echo "Usage: ./AlgoFlow.sh <ProblemID>"
  echo "Example: ./AlgoFlow.sh P1001"
}

# --main--
if [[ $# -eq 0 ]]; then
  log_error "Missing Problem ID."
  show_help
  exit 1
fi

PROB_ID=$(echo $1 | tr '[:lower:]' '[:upper:]')
DIR_NAME="$PROB_ID"

if [[ -d "$DIR_NAME" ]]; then
  log_error "Directory '$DIR_NAME' already exsits."
  exit 1
fi

mkdir "$DIR_NAME"
cat <<EOF > "$DIR_NAME/$PROB_ID.cpp"
/**
 * Problem: $PROB_ID
 * Link: https://www.luogu.com.cn/problem/$PROB_ID
 */
#include <iostream>

using namespace std;

int main()
{
    // TODO: Solve the problem
    return 0;
}
EOF

cat <<EOF > "$DIR_NAME/$PROB_ID.md"
# $PROB_ID Notes
## Algorithm & Logic
- 

## Complexity
- Time: O()
- Space: O()

## Reflection
-
EOF

log_success "Workspace successfully created."
log_info "Path: $(pwd)/$DIR_NAME"
