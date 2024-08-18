#!/bin/bash

#####################################
#
# This file is managed by git
# Do not modify directly
#
# Make local changes in:
#   ~/.bash_profile.local
#
# https://github.com/tnyeanderson/dot
#
#####################################

# ----------------------------------------------------
# SHELL OPTIONS
# ----------------------------------------------------

# Set tab display width to 2
# This is a *terminal* setting that may not be supported everywhere
tabs -2

# vi mode for command editing
# Hint: use Esc+v to open $EDITOR with the current command!
set -o vi

# Expand dir names from variables using tab complete
shopt -s direxpand

# ----------------------------------------------------
# CUSTOM
# ----------------------------------------------------

export GITDIR="$HOME/Desktop/git"
export ZETDIR="$GITDIR/zet"
export DOTDIR="$GITDIR/dot"
export TODOFILE="$HOME/Desktop/TODO.md"

# ----------------------------------------------------
# EDITOR
# ----------------------------------------------------

export EDITOR=vi
export VISUAL=vi

# ----------------------------------------------------
# HISTORY
# ----------------------------------------------------

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

# ----------------------------------------------------
# BASH
# ----------------------------------------------------

# Avoid a warning to use ZSH on MacOS systems
export BASH_SILENCE_DEPRECATION_WARNING=1

# Don't tab-complete tildes
_expand() { true; }

# ----------------------------------------------------
# BASH
# ----------------------------------------------------
#
alias g=git
alias gb='git checkout -b'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gp='git pull'
alias gs='git status'

# ----------------------------------------------------
# GO
# ----------------------------------------------------

# Set GOPATH explicitly in case go isn't installed
# Since we add $GOPATH/bin to the PATH
export GOPATH="$HOME/go"

# ----------------------------------------------------
# PYTHON
# ----------------------------------------------------

# Don't create .pyc files automatically
export PYTHONDONTWRITEBYTECODE=1

# ----------------------------------------------------
# DOCKER
# ----------------------------------------------------

alias d=docker
alias c='docker compose'

# ----------------------------------------------------
# KUBERNETES
# ----------------------------------------------------

if command -v kubectl >/dev/null 2>&1; then
	alias k=kubectl
	# shellcheck disable=SC1090
	source <(kubectl completion bash)
	complete -o default -F __start_kubectl k
fi

# ----------------------------------------------------
# PATH
# ----------------------------------------------------

export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/bin"
# Scripts in ~/bin should override others on the system
# This is insecure, need to switch to a "z" style system
export PATH="$HOME/bin:$PATH"

# ----------------------------------------------------
# FUNCTIONS
# ----------------------------------------------------

..() {
	levels=${1:-1}
	# shellcheck disable=SC2034
	for i in $(seq 1 "$levels"); do
		cd ..
	done
}

cdg() {
	dir="$GITDIR/$1"
	cd "$dir" || echo "failed to cd to $dir"
}

mkcd() {
	# shellcheck disable=SC2164
	mkdir -p "$1" && cd "$1"
}

mkvi() {
	mkdir -p "$(dirname "$1")" && vi "$1"
}

# ----------------------------------------------------
# LESS
# ----------------------------------------------------

# Technicolor man pages
# ks : make the keypad send commands
# ke : make the keypad send digits
# vb : emit visual bell
# mb : start blink
# md : start bold
# me : turn off bold, blink and underline
# so : start standout (reverse video)
# se : stop standout
# us : start underline
# ue : stop underline
export LESS_TERMCAP_mb=$'\e[1;31m' # begin bold -> bold and red
export LESS_TERMCAP_md=$'\e[1;33m' # begin blink -> bold & brown
export LESS_TERMCAP_us=$'\e[1m'    # begin underline -> bold
export LESS_TERMCAP_me=$'\e[0m'    # reset bold/blink
export LESS_TERMCAP_ue=$'\e[0m'    # reset underline
export GROFF_NO_SGR=1              # for konsole and gnome-terminal

# ----------------------------------------------------
# COMPLETIONS
# ----------------------------------------------------

_complete_dirs_in_dir() {
	dir=$1
	word=$2
	if [[ ! -d "$dir" ]]; then
		echo "dir does not exist: $dir"
	fi
	while read -r item; do
		COMPREPLY+=("$item")
	done < <(cd "$dir" && compgen -o nospace -o dirnames "$word")
}

_complete_cdg() {
	_complete_dirs_in_dir "$GITDIR" "$2"
}

complete -o nospace -F _complete_cdg cdg
complete -c cich vich

# ----------------------------------------------------
# Source local profile
# ----------------------------------------------------

# Local changes and overrides should be made in ~/.bash_profile.local
# shellcheck disable=SC1090,SC1091
[[ -f "$HOME/.bash_profile.local" ]] && source "$HOME/.bash_profile.local"
