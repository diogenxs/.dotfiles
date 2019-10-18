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

[ -s "/usr/share/git/git-prompt.sh" ] && source /usr/share/git/git-prompt.sh
[ -s "/usr/share/git/completion/git-completion.bash" ] && source /usr/share/git/completion/git-completion.bash

#
# ENV
#
PS1='\[\033[1;32m\]\u: \[\033[1;37m\]\[\033[1;31m\]\w\[\033[1;36m\]$(__git_ps1)\[\033[1;33m\] \$  \[\033[0m\]'
export VISUAL=vim

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PATH="$PATH:$HOME/go/bin:$HOME/.config/composer/vendor/bin/"

#
# ALIAS
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cdp="cd $HOME/projects"

alias ls='ls --color=auto'
alias la='ls -lha'
alias ll='ls -lh'
alias cp="cp -i"                          
alias df='df -h'                          
alias free='free -m'                      
alias np='nano -w PKGBUILD'
alias more=less

alias open='xdg-open'
alias pacman='sudo pacman'
alias searchhistory='history | grep '
alias start='sudo systemctl start'
alias status='sudo systemctl status'
alias stop='sudo systemctl stop'

#
# FUNCTIONS
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#########
# EXTRA CONF
# load extra file not commited 
[ -s "$HOME/.env.sh" ] && source $HOME/.env.sh