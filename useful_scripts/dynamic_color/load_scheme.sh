#!/bin/sh

if [ $# != 1 ]; then
	echo "usage: $0 <scheme_file>"
	exit 1
fi

default_scheme_dir="~/.local/share/schemes"
scheme_file="$default_scheme_dir/$1"
if [ ! -e "$scheme_file" ]; then
	if [ -e "$1" ]; then
		scheme_file="$1"
	else
		echo "scheme not found"
		exit 1
	fi
fi

# send_esc <num> <col>
send_esc () {
	if [ $# != 2 ]; then
		(>&2 echo "send_esc arg mismatch")
		return 1
	fi

	echo "\033]$1;$2\007\c"
}

. $1

# Default fancy values
: ${cursor:=$color7}
: ${foregnd:=$color7}
: ${backgnd:=$color0}
: ${border:=$backgnd}

# Default bold values to regular colors
:  ${color8:=$color0}
:  ${color9:=$color1}
: ${color10:=$color2}
: ${color11:=$color3}
: ${color12:=$color4}
: ${color14:=$color6}
: ${color15:=$color7}

color_list=\"0\;$color0\;1\;$color1\;2\;$color2\;3\;$color3\;4\;$color4\;5\;$color5\;6\;$color6\;7\;$color7\;8\;$color8\;9\;$color9\;10\;$color10\;11\;$color11\;12\;$color12\;13\;$color13\;14\;$color14\;15\;$color15\;\"

send_esc 4 "$color_list"
send_esc 10 "$foregnd"
send_esc 11 "$backgnd"
send_esc 12 "$cursor"
send_esc 708 "$border"

# send_esc 13 "$mouse_fg"
# send_esc 14 "$mouse_bg"
# send_esc 17 "$highlight"
