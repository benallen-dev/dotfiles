PROMPT="%{$fg_bold[cyan]%}%c%{$reset_color%} $(git_prompt_info)"
[[ -n $NODE_VERSION ]] && PROMPT+="%{$fg_bold[blue]%}node:(%{$fg[yellow]%}$NODE_VERSION%{$fg[blue]%})%{$reset_color%}"
PROMPT+=$'\n'
PROMPT+='%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} )%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

