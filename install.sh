#!/usr/bin/env bash
# Guided setup wizard for the SDD agentic factory (Linux, macOS, WSL, Git Bash).
# Usage: ./install.sh [-t TARGET_DIR] [-s SDD] [-a AGENT] [-y]
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="" SDD="" AGENT="" YES=0

usage() { echo "Usage: $0 [-t target_dir] [-s sdd] [-a agent] [-y]"; exit "${1:-0}"; }
while getopts "t:s:a:yh" o; do
  case $o in
    t) TARGET=$OPTARG;; s) SDD=$OPTARG;; a) AGENT=$OPTARG;; y) YES=1;; h) usage;; *) usage 1;;
  esac
done

list() { for f in "$ROOT/$1"/*.env; do basename "$f" .env; done; }

choose() { # prompt dir
  local prompt=$1 dir=$2 items i=1 pick
  mapfile -t items < <(list "$dir")
  echo "$prompt" >&2
  for it in "${items[@]}"; do echo "  $i) $it" >&2; i=$((i+1)); done
  read -r -p "Choice [1]: " pick </dev/tty
  pick=${pick:-1}
  if [[ $pick =~ ^[0-9]+$ ]] && (( pick >= 1 && pick <= ${#items[@]} )); then
    echo "${items[pick-1]}"
  else
    echo "Invalid choice" >&2; exit 1
  fi
}

if (( ! YES )); then
  echo "== SDD Agentic Factory setup =="
  [[ -n $TARGET ]] || { read -r -p "Target project directory [.]: " TARGET </dev/tty; }
  [[ -n $SDD ]] || SDD=$(choose "Select SDD workflow:" sdd)
  [[ -n $AGENT ]] || AGENT=$(choose "Select agent tool:" agents)
fi
TARGET=${TARGET:-.}
[[ -n $SDD && -n $AGENT ]] || { echo "-s and -a are required with -y" >&2; exit 1; }
[[ $SDD =~ ^[a-z0-9_-]+$ && -f $ROOT/sdd/$SDD.env ]] || { echo "Unknown SDD workflow: $SDD" >&2; exit 1; }
[[ $AGENT =~ ^[a-z0-9_-]+$ && -f $ROOT/agents/$AGENT.env ]] || { echo "Unknown agent: $AGENT" >&2; exit 1; }

# shellcheck disable=SC1090
source "$ROOT/sdd/$SDD.env"; source "$ROOT/agents/$AGENT.env"

render() { # template output
  local content
  content=$(<"$1")
  for k in SDD_NAME SDD_SPEC_DIR SDD_INSTALL_CMD SDD_STEPS AGENT_NAME AGENT_ENGINE AGENT_INSTRUCTIONS_FILE; do
    content=${content//@$k@/${!k}}
  done
  mkdir -p "$(dirname "$2")"
  printf '%s\n' "$content" > "$2"
  echo "created $2"
}

mkdir -p "$TARGET"
render "$ROOT/templates/workflow.md.tpl" "$TARGET/.github/workflows/sdd-$SDD.md"
if [[ -e $TARGET/$AGENT_INSTRUCTIONS_FILE ]]; then
  echo "skipped $TARGET/$AGENT_INSTRUCTIONS_FILE (exists)"
else
  render "$ROOT/templates/instructions.md.tpl" "$TARGET/$AGENT_INSTRUCTIONS_FILE"
fi

cat <<MSG

Done. Next steps:
  1. gh extension install github/gh-aw && (cd "$TARGET" && gh aw compile)
  2. Set up $SDD_NAME: $SDD_INSTALL_CMD
  3. Label an issue 'sdd' to start $AGENT_NAME.
MSG
