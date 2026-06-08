node_version_update() {
  if [[ -f pnpm-lock.yaml ]] || [[ -f package.json ]]; then
    export NODE_VERSION=$(node -v)
  else
    export NODE_VERSION=""
  fi
}

add-zsh-hook chpwd node_version_update
node_version_update
