#!/usr/bin/env bash

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
  local cmd_name=$(basename "$0")
  echo -e "${BLUE}Usage:${RS}"
  echo "$cmd_name new <ProblemID>"
  echo "$cmd_name rm <ProblemID>"
  echo -e "${BLUE}Example:${RS}"
  echo "$cmd_name new P1001"
  echo "$cmd_name rm P1001"
}

do_create() {
  local PROB_ID=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  local DIR_NAME="$PROB_ID"

  if [[ -d "$DIR_NAME" ]]; then
    log_error "Directory '$DIR_NAME' already exsits."
    return 1
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

  log_success "Successfully create '$PROB_ID'"
}

do_delate() {
  local PROB_ID=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  local DIR_NAME="$PROB_ID"
  if [[ ! -d "$DIR_NAME" ]]; then
    log_error "Directory '$DIR_NAME' dose'nt exsit."
    return 1
  fi
  rm -rf "$DIR_NAME"
  log_success "Successfully delate '$PROB_ID'"
}

do_create_all() {
  if [[ $# -eq 0 ]]; then
    log_error "no problem ID."
    echo "please enter at least one problem ID"
    exit 1
  fi

  for PROBLEM in "$@"; do
    do_create "$PROBLEM"
  done

  log_success "Workspace successfully created."
}

do_delate_all() {
  if [[ $# -eq 0 ]]; then
    log_error "no problem ID."
    echo "please enter at least one problem ID"
    exit 1
  fi

  for PROBLEM in "$@"; do
    do_delate "$PROBLEM"
  done

  log_success "Workspace successfully created."
}
# --main--
if [[ $# -eq 0 ]]; then
  show_help
  exit 1
fi

COMMAND=$1
shift

case "$COMMAND" in
  new|create)
    do_create_all "$@"
    ;;
  rm|delete)
    do_delate_all "$@"
    ;;
  *)
    log_error "Unknown command: $COMMAND"
    show_help
    exit 1
    ;;
esac

