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
alias more=less
alias xclip='xclip -sel clip'

alias open='xdg-open'
alias searchhistory='history | grep '
alias start='sudo systemctl start'
alias status='sudo systemctl status'
alias stop='sudo systemctl stop'

alias sshconfig="vim $HOME/.ssh/config"
alias ubuntu="docker run --rm -it ubuntu:latest /bin/bash"
alias centos="docker run --rm -it centos:latest /bin/bash"
alias debian="docker run --rm -it debian:latest /bin/bash"
alias amazonlinux="docker run --rm -it amazonlinux:latest /bin/bash"
alias alpine="docker run --rm -it alpine:latest /bin/ash"
alias grafana="docker run --rm --name=grafana -p 3000:3000 grafana/grafana"

alias heredoc=""
alias tfswitch="tfswitch -b $HOME/bin/terraform"

alias k=kubectl
complete -F __start_kubectl k

alias ec2_list="aws ec2 describe-instances --query 'Reservations[*].Instances[*].{InstanceId:
InstanceId, SubnetId: SubnetId}' --output table $@"
alias ec2_ssh="aws ssm start-session --target $1 "


