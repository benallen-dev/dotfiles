function preexec_update_go() {
    case "$2" in
        go*)
        __EXECUTED_GO_COMMAND=1
        ;;
    esac
}

function precmd_update_go() {
    if [ -n "$__EXECUTED_GO_COMMAND" ]; then
        update_vars_go
        unset __EXECUTED_GO_COMMAND
    fi
}

function update_vars_go() {
  if [[ -f go.mod ]] || [[ -f go.sum ]]; then
	  export __OMZ_VERSIONS_GO=$(go version 2>/dev/null | awk '{print $3}')
  else
	  export __OMZ_VERSIONS_GO=""
  fi
}
