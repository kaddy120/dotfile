# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -AF'
alias l='ls -CF'
alias sl='ls'
alias ..='cd ..'
alias ...='cd ../..'

alias mkdir='mkdir -p'
alias apti='sudo apt install'

# some more gt aliases
alias gs="git status"
alias gc="git commit"
alias gp="git push"

#calendar aliases
alias day='ncal -jb'
alias pcal='ncal -b' #pretty calandar

# poweroff alias 
alias sd="poweroff --p"
alias reboot="poweroff --reboot"

# open rc files alias
alias vimrc="vim ~/.vimrc"
alias bashrc="nvim ~/.bashrc"
alias i3conf="nvim ~/.config/i3/config"
alias vim='nvim'
alias bat='batcat'

alias notes="nvim ~/Notes"
