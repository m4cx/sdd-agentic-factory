#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
for s in $(cd "$ROOT/sdd" && ls *.env | sed 's/.env//'); do
  for a in $(cd "$ROOT/agents" && ls *.env | sed 's/.env//'); do
    d=$(mktemp -d)
    "$ROOT/install.sh" -y -t "$d" -s "$s" -a "$a" >/dev/null
    f="$d/.github/workflows/sdd-$s.md"
    [[ -f $f ]] && ! grep -q '@[A-Z_]*@' "$f" || { echo "FAIL $s/$a"; exit 1; }
    rm -rf "$d"
  done
done
"$ROOT/install.sh" -y -t /tmp/x -s bogus -a claude 2>/dev/null && { echo "FAIL: bogus accepted"; exit 1; }
echo "all passed"
