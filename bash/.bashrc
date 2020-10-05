#
# ~/.bashrc
#
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

#
# ENV
#
#PS1='\[\033[1;32m\]\u: \[\033[1;37m\]\[\033[1;31m\]\W\[\033[1;36m\]$(__git_ps1)\[\033[1;33m\] \$  \[\033[0m\]'
PS1='\[\033[1;32m\]\u: \[\033[1;37m\]\[\033[1;31m\]\W\[\033[1;33m\] \$  \[\033[0m\]'
export VISUAL=vim

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

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

