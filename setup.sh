#!/bin/sh

# Files to link from this directory to their counterparts in $HOME
link_scripts="clip-sc print-colors baseconv"
config=${XDG_DATA_HOME:-$HOME/.config}

# Error/Warning/Info message shorthand
__highlight_err="`tput bold``tput setaf 1`"  # bold red
__highlight_warn="`tput bold``tput setaf 3`" # bold yellow
__highlight_info="`tput bold``tput setaf 2`" # bold green
__highlight_rst="`tput sgr0`"
echo_err  () { echo  "${__highlight_err}ERROR:${__highlight_rst} $@" 1>&2; }
echo_warn () { echo "${__highlight_warn}WARNING:${__highlight_rst} $@" 1>&2; }
echo_info () { echo "${__highlight_info}INFO:${__highlight_rst} $@" 1>&2; }

bundle_rules="basic_utilities i3_setup scripts"
basic_utilities="git zsh neovim tmux"
i3_setup="i3 dunst rofi conky redshift compton xmodmap"
scripts="baseconv"

## ask <question> [default]
#
# form and print a question requiring a yes or no response from the user.
# Responses are matched with [yY].* as "yes" and [nN].* as "no"
#
# @question: String to print as the prompt for the question
# @default: Specifies the default for the question, should it receive no
#     response. `default` can have the following valid values:
#		 "Y" - default to yes
#		 "N" - default to no
#
# @return: 0 if the question was answered 'yes', and 1 if the question was
#     answered 'no.
##
ask ()
{
	local prompt default reply

	prompt="y/n"
	default=
	if [ "${2:-}" = "Y" ]; then
		prompt="Y/n"
		default=yes
	elif [ "${2:-}" = "N" ]; then
		prompt="y/N"
		default=no
	fi

	while true; do
		echo -n "${1} [${prompt}] "
		read reply </dev/tty

		if [ -z "$reply" ]; then
			reply=$default
		fi

		case "$reply" in
			Y*|y*) return 0 ;;
			N*|n*) return 1 ;;
		esac
		echo "Unrecognized response: \"$reply\""
	done
}

## add_link <file> [target]
#
# create a link of a file or a directory in the repo to the corresponding place
# in the home directory.  If there's no second argument, then add_link presumes
# that the correct target is the a .file in the home directory.
##
add_link ()
{
	local src targ yorn cmd targ_dir

	if [ $# -ne 1 ] && [ $# -ne 2 ]; then
		echo "usage: add-link(name [target])"
		return 1
	fi

	src="$PWD/$1"
	targ="${2:-"$HOME/.$1"}"
	targ_dir="`dirname "$targ"`"

	if [ ! -e $targ_dir ]; then
		if ask "$targ_dir does not exist, create it?" Y; then
			mkdir -p "$targ_dir"
		else
			return 3
		fi
	fi
	if [ -e $targ ]; then
		if ask "Overwrite $targ with a link to $src? (y/N)" N; then
			echo "Removing $targ"
			rm "$targ" -rf
		else
			echo "Preserving $targ"
			return 2
		fi
	fi

	cmd="ln -s"
	echo "Making link: $cmd $src $targ"
	$cmd "$src" "$targ"
}

##
# run_config <rule>
#
# executes program-specific setup actions based on the rule, often the name of
# the program, that's handed to it.
##
run_config () {
	case "$1" in
		(neovim) add_link nvim "${config}/nvim" ;;
		(git)    add_link git  "${config}/git"  ;;
		(tmux)   add_link tmux.conf ;;
		(zsh)
			add_link zprofile
			add_link zshrc
			;;

		(x11)
			addlink Xresources
			addlink xinitrc
			;;

		(i3)
			mkdir -p "${config}/i3"
			addlink i3_config "${config}/i3/config"
			;;

		#TODO: unimplemented rules fall though into error case
		(i3status)
		(dunst)
		(rofi)
		(conky)
		(redshift)
		(compton)
		(xmodmap)
		(*)
			err_echo "run_config: no rule for $1 implemented."
			return -1
			;;
	esac
	return 0
}

for prog in ${basic_utilities}; do
	run_config $prog
done
exit 0

## TODO:
#
# Link together scripts
#
mkdir -p "$HOME/.local/bin"
for script in ${link_scripts}; do
	add_link "useful_scripts/$script" "$HOME/.local/bin/$script"
done
