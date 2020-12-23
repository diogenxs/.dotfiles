#
# ~/.bashrc
#
# OPTIONS
#
unset use_color safe_term match_lhs sh
complete -cf sudo
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

[ -s "/usr/share/bash-completion/bash_completion" ] && source /usr/share/bash-completion/bash_completion
[ -s "/usr/share/git/git-prompt.sh" ] && source /usr/share/git/git-prompt.sh
[ -s "/usr/share/git/completion/git-completion.bash" ] && source /usr/share/git/completion/git-completion.bash

#########
# ALIASES
#
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

#########
# FUNCTIONS
#
if [ -f ~/.bash_functions ]; then
. ~/.bash_functions
fi

#
# ENV
#
PS1='\[\033[1;32m\]\u: \[\033[1;37m\]\[\033[1;31m\]\W\[\033[1;36m\]$(__git_ps1)\[\033[1;33m\] \$  \[\033[0m\]'

export VISUAL=vim

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
export GO111MODULE="on"

export AWS_DEFAULT_OUTPUT=table
export AWS_REGION=us-east-1
export AWS_PAGER=less

export ANSIBLE_NOCOWS=1

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi

if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
