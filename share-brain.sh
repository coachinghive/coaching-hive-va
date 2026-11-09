#!/usr/bin/env bash
# Coaching Hive: share ONE second brain with every AI employee.
# Every Hermes profile then reads it at ~/second-brain. Safe to run again any
# time, for example after you add a new AI employee.
set -euo pipefail

# Find the main Hermes folder (on Hostinger Docker it is usually /opt/data).
ROOT="${HERMES_ROOT:-${HERMES_HOME:-}}"
if [ -z "$ROOT" ] && command -v hermes >/dev/null 2>&1; then
  ROOT="$(dirname "$(hermes config path 2>/dev/null)")" || ROOT=""
fi
[ -n "$ROOT" ] || ROOT="$HOME/.hermes"
case "$ROOT" in */profiles/*) ROOT="${ROOT%%/profiles/*}";; esac
BRAIN="$ROOT/second-brain"

# 1. Move an existing second brain (from Module 3) to the shared spot.
if [ ! -d "$BRAIN" ]; then
  best=""; bestn=-1
  for c in "$ROOT/home/second-brain" "$HOME/second-brain" /root/second-brain \
           $(find "$ROOT" -maxdepth 4 -type d -name second-brain ! -path "*/profiles/*" 2>/dev/null); do
    if [ -d "$c" ] && [ ! -L "$c" ]; then
      n=$(find "$c" -type f | wc -l)
      if [ "$n" -gt "$bestn" ]; then best="$c"; bestn="$n"; fi
    fi
  done
  if [ -n "$best" ]; then mv "$best" "$BRAIN"; echo "moved   $best -> $BRAIN"; fi
fi
mkdir -p "$BRAIN"

# 2. Link it into every home a profile might use.
link() {
  local home="$1"; mkdir -p "$home"
  local t="$home/second-brain"
  if [ -L "$t" ]; then ln -sfn "$BRAIN" "$t"
  elif [ -d "$t" ]; then cp -rn "$t"/. "$BRAIN"/ 2>/dev/null || true; mv "$t" "$t.old.$(date +%s)"; ln -s "$BRAIN" "$t"
  else ln -s "$BRAIN" "$t"; fi
  echo "linked  $t"
}
link "$ROOT/home"
if [ "$HOME" != "$ROOT/home" ] && [ -w "$HOME" ]; then link "$HOME"; fi
if [ -d "$ROOT/profiles" ]; then
  for p in "$ROOT"/profiles/*/; do [ -d "$p" ] && link "${p%/}/home"; done
fi

# 3. If run as root, give the files back to the user Hermes runs as.
if [ "$(id -u)" = "0" ]; then
  chown -R --reference="$ROOT" "$BRAIN" 2>/dev/null || true
  for p in "$ROOT/home" "$ROOT"/profiles/*/home; do
    [ -d "$p" ] && chown -h --reference="$ROOT" "$p/second-brain" 2>/dev/null || true
  done
fi

echo
echo "Second brain shared: $BRAIN ($(find "$BRAIN" -type f | wc -l | tr -d ' ') files)"
