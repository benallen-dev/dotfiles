# Works in conjuction with the `versions` plugin
# Reads all params prefixed with __OMZ_VERSIONS_ and displays them in the prompt
function version_prompt() {
	local versions=()
	
	# parameters - zsh builtin associative array of all shell vars
	# (k)parameters - all keys of parameters
	# parameters[(I)__OMZ_VERSIONS_*] - (I) enables case-insensitive glob matching
	
	for key in ${(k)parameters[(I)__OMZ_VERSIONS_*]}; do
		name=${key#__OMZ_VERSIONS_} # the '#' symbol means "remove shortest matching prefix"
		value=${(P)key} # P means Parameter indirection, so you can dereference a var whose name lives in another var

		if [[ -n $value ]]; then
			versions+="%{$fg_bold[blue]%}${name:l}:(%{$fg[yellow]%}$value%{$fg[blue]%})%{$reset_color%}"
		fi
	done
	print -P "${(j: :)versions}"
}
local versions='$(version_prompt)'

PROMPT="%{$fg_bold[cyan]%}%c%{$reset_color%}"
PROMPT+="${versions:+ }${versions}${versions:+ }"
PROMPT+="$(git_prompt_info)"
PROMPT+=$'\n'
PROMPT+='%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

