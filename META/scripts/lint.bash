#!/bin/bash
set -e

usage() {
  echo "marseillebd's notes folder linter"
  echo "Usage ${0} [options]"
  echo ""
  echo "Options:"
  echo "  --help    display this help screen"
  echo "  --color, --no-color"
  echo "      Turn on/off color; on by default"
  echo ""
  echo "Currently checks for:"
  echo "  - the presence of a README.md in every folder"
  echo "    A \`.noreadme\` file will prevent that folder and its subfolders from being checked."
  echo "    Directories beginning with a dot are also ignored."
  echo "  - all-caps todo, fixme, and delme tags"
  echo "    todo: this is a missing feature, or the implementation is known to be sub-optimal"
  echo "    fixme: this is known to be broken"
  echo "    delme: this was kept around just in case, but is meant to be deleted"
  echo "  - all-caps debug tag, if the line is not commented-out"
  echo "    We recognize line comments from the following file extensions:"
  echo "      sh,bash,zsh, py, h,c,hpp,cpp,rs java,cs, hs."
  echo "    More can be added quite easily; send a PR to https://github.com/edemko/NOTES"
  echo "    You must use the line-comment, block comments won't work."
}

main() {
  runOptions "$@"
  checkTag 'TO''DO'
  checkTag 'FIX''ME'
  checkTag 'DEL''ME'
  checkReadmes "$notesdir"
  checkDebugs "$notesdir"
}

###### Global Variables ######

here="$(realpath "$(dirname "$(readlink "${0}")")")"
notesdir="$(dirname "$(dirname "$here")")"

color=1

###### Helpers ######

runOptions() {
  while [[ "$#" -ne 0 ]]; do
    case "$1" in
      --help) usage; exit 0 ;;
      --color) color=1; shift ;;
      --no-color) color=0; shift ;;
      *) usage; exit 1 ;;
    esac
  done
}

lintmsg() {
  if [[ color -ne 0 ]]; then
    echo -e "[\033[1;31m$1\033[0m]" "$2"
  else
    echo "[$1] $2"
  fi
}

###### Checks ######

checkTag() {
  local tag grepFlags
  tag="$1"
  grepFlags=""
  if [[ "$color" -ne 0 ]]; then grepFlags+=" --color"; fi
  grep $grepFlags -srInF "$tag" "$notesdir" || true
}

checkDebugs() {
  local dir
  dir="$1"
  for f in "$dir"/*; do
    if [[ -f "$f" ]]; then
      checkDebug "$f"
    elif [[ -d "$f" ]]; then
      checkDebugs "$f"
    fi
  done
}

checkDebug() {
  local f
  f="$1"
  local comment pattern
  case "$f" in
    *.sh|*.bash|*.zsh) comment='#' ;;
    *.py) comment='#' ;;
    *.h|*.c|*.hpp|*.cpp|*.rs) comment='//' ;;
    *.java) comment='//' ;;
    *.hs) comment='--' ;;
    *) return ;;
  esac
  # NOTE this is perl regexp syntax
  # NOTE `\K` makes it pretend that the match starts at that point
  # NOTE `(?!...)` for negative lookahead
  pattern='^\s*+(?!'"$comment"').*\KDE''BUG'

  local grepFlags
  grepFlags=""
  if [[ "$color" -ne 0 ]]; then grepFlags+=" --color"; fi
  # NOTE -P enables perl, -H re-enables the filename prefix which perl otherwise turns off
  grep $grepFlags -sInHP "$pattern" "$f" || true
}

checkReadmes() {
  local dir
  dir="$1"
  case "$dir" in .*) return;; esac
  if [[ -f "$dir/.noreadme" ]]; then return; fi
  if [[ ! -f "$dir/README.md" ]]; then
    lintmsg "readme-missing" "$dir"
  fi
  for f in "$dir"/*; do
    if [[ -d "$f" ]]; then
      checkReadmes "$f"
    fi
  done
}

###### Execute ######

main "$@"
