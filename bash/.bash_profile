# function for testing if a Git For Windows environment
# example:
# if testIsGitForWindows; then
#   echo "is Git for Windows"
# fi
testIsGitForWindows() {
	[[ "$(head -1 /proc/version)" =~ "XMINGW".* ]]
}

# function for testing if a WSL environment
# example:
# if testIsWSL; then
#   echo "is WSL"
# fi
testIsWSL() {
	[[ "$(head -1 /proc/version)" =~ .*"-microsoft-standard".* ]]
}


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000



# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# remove ugly green background from ow 'other, writable' and tw 'sticky, writable'
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

# source alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# X - Export display and force rendering on windows side
export DISPLAY=localhost:0
export LIBGL_ALWAYS_INDIRECT=1


# when docker and service command are available; start Docker if not already running
if [ command -v service ] &> /dev/null && [ command -v docker ] &> /dev/null; then
	wsl -u root -e sh -c "service docker status || service docker start"
fi


export EDITOR=vi
export SUDO_EDITOR=vi
export VISUAL=vi


PS1="\n\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`\\w \[\033[34m\]\$\[\033[0m\] "

if command -v tmux &> /dev/null && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux a -t default || exec tmux new -s default && exit;
fi
