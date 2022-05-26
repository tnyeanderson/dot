#!/bin/bash
# shellcheck disable=SC2034

# Styling for terminal Output
# echo "this is ${bold}bold${endstyle} but this isn't"

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GRAY=$(tput setaf 240)

# Don't work yet
RESETTEXT='\e[39m'
RESETBG='\e[49m'

BOLD=$(tput bold)  # Select bold mode
DIM=$(tput dim)    # Select dim (half-bright) mode
ULINE=$(tput smul) # Enable underline mode

CSCREEN=$(tput clear) # Clear screen and move the cursor to 0,0
CBLINE=$(tput el 1)   # Clear to beginning of line
CELINE=$(tput el)     # Clear to end of line
CESCREEN=$(tput ed)   # Clear to end of screen

NOSTYLE=$(tput sgr0) # Reset text format to the terminal's default
HIDDEN='\e[2m'       # Hide text (useful for passwords)

function insertchars() {
	tput ich "$1" # Insert N characters (moves rest of line forward!)
}

function insertlines() {
	tput il "$1" # Insert N lines
}

function setbackground() {
	tput setab "$1"
}

function settextcolor() {
	tput setaf "$1"
}

function colorhelp() {
	echo 'Num  Colour    #define         R G B'
	echo
	echo '0    black     COLOR_BLACK     0,0,0'
	echo '1    red       COLOR_RED       1,0,0'
	echo '2    green     COLOR_GREEN     0,1,0'
	echo '3    yellow    COLOR_YELLOW    1,1,0'
	echo '4    blue      COLOR_BLUE      0,0,1'
	echo '5    magenta   COLOR_MAGENTA   1,0,1'
	echo '6    cyan      COLOR_CYAN      0,1,1'
	echo '7    white     COLOR_WHITE     1,1,1'
}
