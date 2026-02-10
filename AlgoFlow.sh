#!/usr/bin/env bash

# --config--
AUTHOR="chunyao"
LANGUAGE="cpp"
set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates"
TEMPLATE_CPP="$TEMPLATE_DIR/template.cpp"
TEMPLATE_MD="$TEMPLATE_DIR/template.md"

# --color constants--
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
# reset color
RS='\033[0m'

# --fuctions--
log_info() { echo -e "${BLUE}[INFO]${RS} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${RS} $1"; }
log_error() { echo -e "${RED}[ERROR]${RS} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${RS} $1"; }

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
    log_error "Directory '$DIR_NAME' already exists."
    return 1
  fi

  mkdir -p "$DIR_NAME"

  if [[ -f "$TEMPLATE_CPP" ]]; then
    sed -e "s/{{PROB_ID}}/$PROB_ID/g" -e "s/{{AUTHOR}}/$AUTHOR/g" "$TEMPLATE_CPP" > "$DIR_NAME/$PROB_ID.cpp"
    log_info "Used external CPP template."
  else
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
  fi

  if [[ -f "$TEMPLATE_MD" ]]; then
    sed "s/{{PROB_ID}}/$PROB_ID/g" "$TEMPLATE_MD" > "$DIR_NAME/$PROB_ID.md"
    log_info "Used external MD template."
  else
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
  fi

  log_success "Successfully create '$PROB_ID'"
}

do_delate() {
  local PROB_ID=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  local DIR_NAME="$PROB_ID"
  if [[ ! -d "$DIR_NAME" ]]; then
    log_error "Directory '$DIR_NAME' dose'nt exist."
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
}

do_clean() {
  FILES=$(find . -type f ! -name "*.cpp" ! -name "*.md" ! -name "*.sh" ! -path "*/.*")

  if [[ -z "$FILES" ]]; then
    echo "Nothing to clean here"
    return 0
  fi

  echo "$FILES"
  echo -e "${YELLOW}[WARNING]${RS} "
  read -p "Are you sure you want to clean the files above? (y/n) " CONFIRM

  if [[ "$CONFIRM" == [yY] ]]; then
    echo "$FILES" | xargs rm -f
    echo -e "${GREEN}[Done]${RS}"
  else
    echo -e "${GREEN}[Aborted]${RS}"
  fi
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
  clean)
    do_clean
    ;;
  update)
    cd "$SCRIPT_DIR" && sudo git pull
    log_success "AlgoFlow updated to the latest version!"
    ;;
  *)
    log_error "Unknown command: $COMMAND"
    show_help
    exit 1
    ;;
esac

