# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# remaping caps_lock to esc key

gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

# activate prompt colour
color_prompt=yes

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
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# source srup_mkdir function 
[ -f $HOME/bin/_mkdir.sh ] && . $HOME/bin/_mkdir.sh

# source functions and alias for managing virtual machines
[ -f $HOME/bin/start_vms.sh ] && . $HOME/bin/start_vms.sh

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

TERM=xterm-256color

# enable vim-mode in the terminal
set -o vi
# ~/.bashrc

SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    # echo "Initialising new SSH agent..."
   /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    # echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    # ssh-add -q
    [ -f "$HOME/.ssh/_kaddy120" ] && ssh-add -q "$HOME/.ssh/_kaddy120" 
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# bash splash message.
# figlet -cl "Make a mess; perfectionsm is oppression"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# fzf 
# change the default util, find, that fzf uses to search for files to fd-find
# fd-find ignores files listed in .gitignore
export FZF_DEFAULT_COMMAND="fdfind --type f"

# show preview window by default
export FZF_DEFAULT_OPTS="--preview 'batcat --color=always {}'"

# source fzf key-binding 
# Ctrl-t to start fzf
# Ctrl-r to search for history command
# Alt-c quickly switch to subdirectory
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

# only display the current directory in the termianl prompt
PS1='\[\033[32;1m\]\u@\h\[\033[00m\]:\[\033[34;1m\]\W\[\033[00m\]$ '

## add ant to path
#

# export JAVA_HOME="$HOME/myprograms/jdk8u402-b06"
export JAVA_HOME="$HOME/myprograms/amazon-corretto-17.0.11.9.1-linux-x64"
export ANT_HOME="$HOME/myprograms/apache-ant-1.10.14"
export WILDFLY_HOME="$HOME/myprograms/wildfly-32.0.0.Final"
export TOMCAT_HOME="$HOME/myprograms/apache-tomcat-9.0.89"
export CATALINA_HOME="$HOME/myprograms/apache-tomcat-9.0.89"
export MAVEN_HOME="$HOME/myprograms/apache-maven-3.9.6"
export PATH="$PATH:$ANT_HOME/bin"
export PATH="$PATH:$TOMCAT_HOME/bin"
export PATH="$PATH:$MAVEN_HOME/bin"
export PATH="$HOME/myprograms/idea-IU-241.15989.150/bin:$PATH"

# update docker group to include user
# newgrp docker

# Esc+v start editing the terminal command in nvim
export PSQL_EDITOR="/usr/local/bin/nvim"
export EDITOR="/usr/local/bin/nvim"
export VISUAL="/usr/local/bin/nvim"

# environment variables to connect to psql
export PGHOST="localhost"
export PGPORT="5432"
export PGUSER="postgres"



# Load Angular CLI autocompletion.
source <(ng completion script)
