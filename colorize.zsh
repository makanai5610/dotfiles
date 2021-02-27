#!/bin/zsh

# constants
ESC='\e['
ESC_END='m'
STYLE_OFF=${ESC}${ESC_END}

FONT_COLOR=3
BACKGROUND_COLOR=4

# colors
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

FONT_BLACK=${FONT_COLOR}${BLACK}
FONT_RED=${FONT_COLOR}${RED}
FONT_GREEN=${FONT_COLOR}${GREEN}
FONT_YELLOW=${FONT_COLOR}${YELLOW}
FONT_BLUE=${FONT_COLOR}${BLUE}
FONT_MAGENTA=${FONT_COLOR}${MAGENTA}
FONT_CYAN=${FONT_COLOR}${CYAN}
FONT_WHITE=${FONT_COLOR}${WHITE}

BACKGROUND_BLACK=${BACKGROUND}${BLACK}
BACKGROUND_RED=${BACKGROUND}${RED}
BACKGROUND_GREEN=${BACKGROUND}${GREEN}
BACKGROUND_YELLOW=${BACKGROUND}${YELLOW}
BACKGROUND_BLUE=${BACKGROUND}${BLUE}
BACKGROUND_MAGENTA=${BACKGROUND}${MAGENTA}
BACKGROUND_CYAN=${BACKGROUND}${CYAN}
BACKGROUND_WHITE=${BACKGROUND}${WHITE}

# attributes
BOLD=1
UNDER_LINE=4
BLINK=5
REVERSE_VIDEO=7
INVISIBLE_TEXT=8

function reset_style() {
    echo -en ${STYLE_OFF}
}

function echo_success() {
    echo -en "${ESC}${FONT_GREEN}${ESC_END}$1${STYLE_END}"
    reset_style
}

function set_style_success() {
    echo -en "${ESC}${FONT_GREEN}${ESC_END}${STYLE_END}"
}

function echo_failure() {
    echo -en "${ESC}${FONT_RED}${ESC_END}$1${STYLE_END}"
    reset_style
}

function set_style_failure() {
    echo -en "${ESC}${FONT_RED}${ESC_END}${STYLE_END}"
}

function echo_processing() {
    echo -en "${ESC}${FONT_WHITE};${BLINK}${ESC_END}$1${STYLE_END}"
    reset_style
}

function set_style_processing() {
    echo -en "${ESC}${FONT_WHITE};${BLINK}${ESC_END}${STYLE_END}"
}

function echo_note() {
    echo -en "${ESC}${FONT_WHITE};${BOLD}${ESC_END}$1${STYLE_END}"
    reset_style
}

function set_style_note() {
    echo -en "${ESC}${FONT_WHITE};${BOLD}${ESC_END}${STYLE_END}"
}
