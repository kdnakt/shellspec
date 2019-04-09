#shellcheck shell=sh

# shellcheck source=lib/libexec.sh
. "${SHELLSPEC_LIB:-./lib}/libexec.sh"
use includes puts putsn

time_result() {
  case ${1%% *} in ( real | user | sys )
    case ${1##* } in ( *[!0-9.]* ) return 1; esac
    echo "$1" && return 0
  esac
  return 1
}

executer_log() {
  while IFS= read -r line; do
    if time_result "$line" >> "$1.tmp"; then
      includes "$line" "sys " && mv "$1.tmp" "$1"
      continue
    fi
    putsn "$line"
  done
}