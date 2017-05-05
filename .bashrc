# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

function dl {
    if [ -z "$(type -t devel-local)"  ]; then
        source ~/perl5/bin/devel-local.sh
    fi
    devel-local $@;
}
function debug {
    cat $1 | mojo nopaste shadowcat
}

alias devdb='psql -U socialflow_web -h pg-site.dev.saturn.sfsrv.net -d sf_web'
alias proddb='psql -U prod_user -h ro.pg-site.prod.priv.sf -d sf_web'
#alias startup='SITE_ENVIRONMENT=dev SOCIALFLOW_WEB_PATH=~/yml CATALYST_DEBUG=1 DBIC_TRACE="1=/tmp/dbic_trace.log" DBIC_TRACE_PROFILE=console plackup -s Starman --workers 3 -E test -port 6732 socialflow_web.psgi | tee -a plack.log'
alias startup='SITE_ENVIRONMENT=dev SOCIALFLOW_WEB_PATH=~/yml plackup -s Starman --workers 3 -E test -port 6732 socialflow_web.psgi | tee -a plack.log'

#alias sf_web_app='SITE_ENVIRONMENT=dev SOCIALFLOW_WEB_PATH=/etc/socialflow/SocialFlow-Web-Config/ CATALYST_DEBUG=1 DBIC_TRACE="1=/tmp/dbic_trace.log" DBIC_TRACE_PROFILE=console $HOME/perl5/bin/plackup -s Starman --workers 3 --port 6732 2>/tmp/plack.log'
alias sfcpanm='cpanm --mirror=http://cpan-mirror.dev.saturn.sflow.us:25123 --mirror-only'
alias grepc='grep --color -rn'
alias sfworker='SITE_ENVIRONMENT=dev perl bin/sf-workqueue workers --job'
alias venv='source ~/virtualenv/bin/activate'
alias npm='~/node/bin/npm'
alias node='~/node/bin/node'
alias sassy='sass --watch root/static/scss:root/static/css'
alias tad='tmux attach -d'
alias gbd='git branch -D'

# REMOVE AFTER TESTING
alias testsfadspy='python main.py --facebook_file data/fb.json --facebook_link https://facebook.com/10153193703181367 --outfile output/OutputWrapReport.pptx'

export PYTHONPATH=$PYTHONPATH:/home/blai/virtualenv
export PYTHONPATH=$HOME/dev_sf/py/python-pptx:$PYTHONPATH
export PATH=$PATH:~/perl5/bin/
export PATH=$PATH:~/perl5/lib/perl5/
export PATH=$PATH:~/node/bin/
export PATH=/home/blai/phantomjs-2.1.1-linux-x86_64/bin:$PATH
export SOCIALFLOW_WEB_PATH=~/yml

#export HISTSIZE=300000
#export HISTCONTROL=ignorespace:ignoredups
shopt -s histappend
PROMPT_COMMAND='history -a'

eval $( perl -Mlocal::lib )
source `which devel-local.sh`
