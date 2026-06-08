# Sets env vars for programming language versions
# Useful in theme prompts

# Handle $0 according to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

__PROMPT_DIR="${0:A:h}"

source "$__PROMPT_DIR/versions-go.zsh"
source "$__PROMPT_DIR/versions-node.zsh"
source "$__PROMPT_DIR/versions-rust.zsh"

function chpwd_update_version_vars() {
	update_vars_go
	update_vars_node
	update_vars_rust
}

function preexec_update_version_vars() {
	preexec_update_go $@
	preexec_update_node $@
	preexec_update_rust $@
}

function precmd_update_version_vars() {
	precmd_update_go
	precmd_update_node
	precmd_update_rust
}

autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_update_version_vars
add-zsh-hook precmd precmd_update_version_vars
add-zsh-hook preexec preexec_update_version_vars

