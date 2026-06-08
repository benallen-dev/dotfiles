function preexec_update_rust {
    case "$2" in
        rustc*|cargo*|rust*)
        __EXECUTED_RUST_COMMAND=1
        ;;
    esac
}

function precmd_update_rust {
    if [ -n "$__EXECUTED_RUST_COMMAND" ]; then
        update_vars_rust
        unset __EXECUTED_RUST_COMMAND
    fi
}

function update_vars_rust {
  if [[ -f Cargo.toml ]]; then
	  export __OMZ_VERSIONS_RUST=$(rustc --version 2>/dev/null | awk '{print $2}')
  else
	  export __OMZ_VERSIONS_RUST=""
  fi
}
