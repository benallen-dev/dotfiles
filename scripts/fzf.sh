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

local dirs=( \
	"~/.dotfiles/" \
	"~/projects/benallen-dot-dev/" \
	"~/projects/artifact-deployer/" \
	"~/projects/htmx/" \
	"~/projects/kata-machine/" \
)
#fp (find project) - cd to predetermined list of project dirs
# TODO: just list all subdirs instead of manually having to specify everything
fp() {
	local dir

	dir=$( printf '%s\n' "${dirs[@]}" | fzf -q "$1")
	cd ${dir//\~//home/benallen}
}

# the same as fp, but opens in nvim
nvimf() {
	local dir

	dir=$( printf '%s\n' "${dirs[@]}" | fzf -q "$1")
	nvim ${dir//\~//home/benallen}
}
