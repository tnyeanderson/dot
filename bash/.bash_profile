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
export GITHUBDIR="$HOME/Desktop/github"
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

# Bash completion in MacOS
homebrew_bash_complete=/opt/homebrew/etc/profile.d/bash_completion.sh
# shellcheck disable=1090
[[ -r "$homebrew_bash_complete" ]] && source "$homebrew_bash_complete"

# Alias completion functions
# shellcheck disable=1091
source "$HOME/.bash_alias_completion"

# ----------------------------------------------------
# GIT
# ----------------------------------------------------

if command -v git >/dev/null 2>&1; then
	alias_with_completion g git
	alias_with_completion ga git add
	alias_with_completion gb git checkout -b
	alias_with_completion gc git commit
	alias_with_completion gd git diff
	alias_with_completion gdc git diff --cached
	alias_with_completion gl git log
	alias_with_completion gp git pull
	alias_with_completion gs git status
fi

# ----------------------------------------------------
# PYTHON
# ----------------------------------------------------

# Don't create .pyc files automatically
export PYTHONDONTWRITEBYTECODE=1

# ----------------------------------------------------
# DOCKER
# ----------------------------------------------------

if command -v docker >/dev/null 2>&1; then
	alias_with_completion d docker
	alias_with_completion c docker compose
fi

# ----------------------------------------------------
# KUBERNETES
# ----------------------------------------------------

__complete_cobra() {
	local program=$1
	shift
	while read -r item; do
		COMPREPLY+=("$item")
	done < <("$program" __completeNoDesc "$@" 2>/dev/null | sed '$d')
}

__complete_kc() {
	if [[ "${#COMP_WORDS[@]}" -gt 2 ]]; then
		return
	fi
	__complete_cobra kubectl config use-context "${COMP_WORDS[COMP_CWORD]}"
}

if command -v kubectl >/dev/null 2>&1; then
	# shellcheck disable=SC1090
	source <(kubectl completion bash)

	alias k=kubectl
	complete -o default -F __start_kubectl k

	alias kc='kubectl config use-context'
	complete -o default -F __complete_kc kc
fi

# ----------------------------------------------------
# PATH
# ----------------------------------------------------

export PATH="$PATH:$HOME/go/root/current/go/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/bin"
# Scripts in ~/bin should override others on the system
# This is insecure, need to switch to a "z" style system
export PATH="$HOME/bin.local:$PATH"
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

cdgh() {
	dir="$GITHUBDIR/$1"
	cd "$dir" || echo "failed to cd to $dir"
}

mkcd() {
	# shellcheck disable=SC2164
	mkdir -p "$1" && cd "$1"
}

mkvi() {
	mkdir -p "$(dirname "$1")" && vi "$1"
}

ssha() {
	if [[ -z "$SSH_AGENT_PID" ]] || [[ -z "$SSH_AUTH_SOCK" ]]; then
		eval "$(ssh-agent)"
	fi
	ssh-add
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

# TODO: In bash 5.3, the read can be replaced with:
#   compgen -V COMPREPLY
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

_complete_cdgh() {
	_complete_dirs_in_dir "$GITHUBDIR" "$2"
}

complete -o nospace -F _complete_cdg cdg
complete -o nospace -F _complete_cdgh cdgh
complete -c cich vich

# ----------------------------------------------------
# Source local profile
# ----------------------------------------------------

# Local changes and overrides should be made in ~/.bash_profile.local
# shellcheck disable=SC1090,SC1091
[[ -f "$HOME/.bash_profile.local" ]] && source "$HOME/.bash_profile.local"
