#shellcheck shell=sh disable=SC2004

shellspec_constants
shellspec_proxy find_files shellspec_find_files
shellspec_proxy puts shellspec_puts
shellspec_proxy putsn shellspec_putsn
shellspec_proxy escape_quote shellspec_escape_quote
shellspec_proxy trim shellspec_trim

shellspec_import posix
shellspec_proxy unixtime shellspec_unixtime

initialize_id() {
  id='' id_state='begin'
}

increasese_id() {
  if [ "$id_state" = "begin" ]; then
    id=$id${id:+:}1
  else
    id_state="begin"
    case $id in
      *:*) id="${id%:*}:$((${id##*:} + 1))" ;;
      *) id=$(($id + 1)) ;;
    esac
  fi
}

decrease_id() {
  [ "$id_state" = "end" ] && id=${id%:*}
  id_state="end"
}

is_constant_name() {
  case $1 in ([!A-Z_]*) return 1; esac
  case $1 in (*[!A-Z0-9_]*) return 1; esac
}

is_function_name() {
  case $1 in ([!a-zA-Z_]*) return 1; esac
  case $1 in (*[!a-zA-Z0-9_]*) return 1; esac
}
