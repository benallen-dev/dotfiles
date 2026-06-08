# terminal coloring
export CLICOLOR=1
export LSCOLORS=dxFxCxDxBxegedabagacad

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

local git_branch='$(git_prompt_info)%{$reset_color%}'
local versions='$(version_prompt)'

PROMPT="%{$fg[green]%}╭─%n@%m %{$reset_color%}%{$fg[yellow]%}in %~%{$reset_color%}${versions:+ }${versions}${versions:+ }${git_branch}
%{$fg[green]%}╰\$ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}on "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}%{$fg[red]%} ✘ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED=true
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" +"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR=%{$fg[green]%}

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" -"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR=%{$fg[red]%}

