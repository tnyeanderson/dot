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
# PATH
# ----------------------------------------------------

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/bin"
# Scripts in ~/bin should override others on the system
# This is insecure, need to switch to a "z" style system
export PATH="$HOME/bin:$PATH"

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
# Source local profile
# ----------------------------------------------------

# Local changes and overrides should be made in ~/.bash_profile.local
# shellcheck disable=SC1090
[[ -f "$HOME/.bash_profile.local" ]] && source "$HOME/.bash_profile.local"
