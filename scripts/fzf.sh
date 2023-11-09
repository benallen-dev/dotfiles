# Adds a couple of handy-dandy commands that use fzf

# From https://github.com/junegunn/fzf/wiki/examples#changing-directory

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Custom stuff

# If fzf-paths.sh exists, source it. If not, fall back to defaults
#
# This file is expected to provide two configs:
#
# dirs - a list of directories to search
# home - the home directory to replace ~ with
if [ -f "$HOME/.dotfiles/scripts/fzf.conf" ]; then
	source $HOME/.dotfiles/scripts/fzf.conf
else
	source $HOME/.dotfiles/scripts/fzf.conf.default
fi

#fp (find project) - cd to predetermined list of project dirs
fp() {
	local dir

	dir=$( printf '%s\n' "${dirs[@]}" | fzf -q "$1")
	cd ${dir//\~/$home}
}

# the same as fp, but opens in nvim
nvimf() {
	local dir

	dir=$( printf '%s\n' "${dirs[@]}" | fzf -q "$1")
	nvim ${dir//\~/$home}
}
