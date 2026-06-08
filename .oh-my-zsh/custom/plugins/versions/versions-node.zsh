function preexec_update_node {
    case "$2" in
        nvm*|node*)
        __EXECUTED_NODE_COMMAND=1
        ;;
    esac
}

function precmd_update_node {
    if [ -n "$__EXECUTED_NODE_COMMAND" ]; then
        update_vars_node
        unset __EXECUTED_NODE_COMMAND
    fi
}

function update_vars_node {
  if [[ -f pnpm-lock.yaml ]] || [[ -f package.json ]]; then
	  export __OMZ_VERSIONS_NODE=$(node -v 2>/dev/null)
  else
	  export __OMZ_VERSIONS_NODE=""
  fi
}
