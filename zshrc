# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=4000
setopt appendhistory beep extendedglob nomatch
unsetopt autocd notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/luci/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

unsetopt BEEP

#
# Sources:
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# https://code.tutsplus.com/tutorials/how-to-customize-your-command-prompt--net-24083
# http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
#

# Kill delay on mode switch
export KEYTIMEOUT=1

lhs_title='%F{14}%n%f'
if [ -n "$SSH_CONNECTION" ]; then
	lhs_title+='@%m '
else
	lhs_title+=' '
fi

# Saved non-Unicode prompt
#prompt_char='>'
prompt_char='❯'


setopt prompt_subst
# Saved single-line prompt
# PROMPT='$(echo $lhs_title)%F{cyan}${PWD/#$HOME/~} %(?.%F{green}.%F{red})${prompt_char}%f '
PROMPT='
$(echo $lhs_title)%F{14}${PWD/#$HOME/~}
 %B%(?.%F{40}.%F{160})${prompt_char}%f%b '

# RPROMPT='%t'

# LESS_TERMCAP_* variables for colouring man pages
## This 'hack' abuses the termcap settings for less to, instead of
## emphasis or underlining, set the output to certain colours.
#     mb - Start blinking mode
#     md - start bold mode
#     me - End all mode
#     so - Start standout mode (used for search matches and less prompt)
#     se - End standout mode 
#     us - Start underlining
#     ue - End underlining
#     ZH - Start italic mode
#     ZR - End italic mode
export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 3)  # bold yellow
export LESS_TERMCAP_md=$(tput bold; tput setaf 1)  # bold red
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput smso; tput bold)     # bold reverse
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput setaf 15) # underlined bright white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_ZH=$(tput sitm; tput setaf 6)  # cyan
export LESS_TERMCAP_ZR=$(tput ritm; tput sgr0)

# see terminfo(5) for reference -- simply enforcing defaults with tput
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

export LESS="$LESS --quit-if-one-screen"

export EDITOR=nvim
export GIT_EDITOR=nvim
export GIT_PAGER=less
export MANPAGER=less
# export MANPAGER='bash -c "nvim -c \"set ft=man nomod nolist ignorecase scrolloff=999\" </dev/tty <(col -b)"'
# For dumb terminals that don't do 256 automatically, like the one at
# work. This might break stuff in the future, but it's good enough for
# now.
if [ "$TERM" = "xterm" ]; then
	TERM="xterm-256color"
fi

alias term="urxvtc -e tmux"
# alias term=urxvtc
alias vim=nvim
alias vims="vim -S Session.vim"
alias htop_user='HTOPRC=/home/lucienne/.config/htop/compact_htoprc htop --user=$USER'
function cdiff () {
	diff --side-by-side --width=${COLUMNS} --color=always "$@" | less
}
# TODO: dress up nicer
function ssh-getip () {
	ssh -G $@ | awk '/^hostname /{print $2;}'
}

# function sudo {
# 	cmd="$1"
# 	shift
# 	command sudo `readlink -f "$cmd"` $@
# }

alias tmux='tmux -2 -u'
alias w3m-img='w3m -o auto_image=TRUE'
alias clip='xclip -selection c'
alias :q='exit'

alias ls="ls --color --group-directories-first"
alias ll="ls -lh"
alias la="ls -lhA"
alias l="ls -C"
alias gs="git status -s"

alias sscrot="scrot -s '%Y-%m-%d_\$wx\$h.png' -e 'mv \$f $HOME/Pictures/screenshots/'"
# alias wscrot="scrot -b -c -d 3 -u -e feh -s '%Y-%m-%d_\$wx\$h.png'"
alias wscrot="scrot -b -c -d 3 -u"
alias feh="feh --scale-down"
alias fehb="feh -g 720x680 -Z"

alias fl="find -maxdepth 1"
alias fln="find -maxdepth 1 -name"
alias fn="find -name"
alias du-sort="du -sh (|.)* | sort -h"

function pigz-folder () {
	which pigz > /dev/null
	if [ $? -ne 0 ]; then
		echo "pigz is not installed"
		return 1;
	fi
	if [ $# -ne 1 ] && [ $# -ne 2 ]; then
		echo "Usage: $0 <folder> [target_name]"
		return 1
	fi
	if [ -d "$1" ]; then
		local t=""
		if [ "$#" -eq 2 ]; then
			t="$PWD/$2.tar.gz"
		else
			t="$PWD/`basename $1`.tar.gz"
		fi
		pushd `dirname $1` > /dev/null
		tar cf - "`basename $1`" | pigz --best > "$t"
		popd > /dev/null
	else
		echo "\"$1\" is not a directory."
	fi
}

function makeless () {
	make $@ 2>&1 | less
}

# azure cli completions
if [ -f '$HOME/.local/share/azure-cli/az.completion' ]; then
	autoload -U bashcompinit
	bashcompinit
	source '/home/luci/.local/share/azure-cli/az.completion'
fi

if [ -d /etc/profile.d ]; then
	for i in /etc/profile.d/*.sh; do
		[ -r "$i" ] && . $i
	done
fi

#[ -d "$HOME/.zsh-completions" ] && fpath=("$HOME/.zsh-completions" fpath)

typeset -T LD_LIBRARY_PATH ld_library_path :
ld_library_path=("${HOME}/.local/lib" $ld_library_path)
export LD_LIBRARY_PATH

path=("${HOME}/.local/sbin" $path)
path=("${HOME}/.local/bin" $path)
export PATH

# exit 0 even if the previous short commands fail
true
