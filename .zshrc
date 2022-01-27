export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag-cmd"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git)

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=${HOME}/cmd/src/go/bin:${HOME}/cmd/src/bin:${PATH}

function dedup_path {
    if [ -n "$PATH" ]; then
        old_PATH=$PATH:; PATH=
        while [ -n "$old_PATH" ]; do
            x=${old_PATH%%:*}       # the first remaining entry
            case $PATH: in
                *:"$x":*) ;;         # already there
                *) PATH=$PATH:$x;;    # not there yet
            esac
            old_PATH=${old_PATH#*:}
        done
        PATH=${PATH#:}
        unset old_PATH x
    fi
}

source $ZSH/oh-my-zsh.sh

export PAGER=less

EMACS=$(which emacsclient)
if [[ $(uname) == 'Darwin' ]] ; then
    alias ls='ls -FhG'
    [[ -e /Applications/Emacs.app/Contents/MacOS/Emacs ]] && \
      EMACS="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
    EMACS="TERM=xterm-24bits $EMACS -nw"
    alias tmacs="TERM=xterm-24bits tmux new -s emacs"
else
    alias ls='ls -Fh --color=yes'
    EMACS="$EMACS -nw"
    alias tmacs="tmux new -s emacs"
fi

alias em=$EMACS
export EDITOR=$EMACS

export GIT_EDITOR=$EDITOR
alias gs='git status'
alias ts='tig status'

alias -g csd=~/cmd/src/dotfiles

alias ssh='TERM=xterm ssh -v'
alias sl=ls
alias lslt='ls -lt'
alias cg='egrep -v "^($|[[:space:]]*#|;)" ' # strip out comments
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias his='history'
alias hgrep='his | grep'

alias tls='tmux ls'
alias tn='tmux new-session -s '
alias tnew='tmux new-session -s '
alias ta='tmux attach -t '
alias tattach='tmux attach -d -t '
alias tcd='tmux attach -c $PWD -t '

# FIXME: should be function
alias ansible-init='. ./venv/bin/activate; source ansible/hacking/env-setup; export EC2_INI_PATH=inventory/ec2.ini; export ANSIBLE_HOST_KEY_CHECKING=False'
alias tf=terraform
alias tg='terragrunt init && terragrunt '

alias -g tfgrep='grep -v terraform.tfstate'

export GOPATH=$HOME/cmd/src/go
export GEM_PATH=$HOME/.gems:/usr/lib/ruby/gems/2.0.0

export KUBECONFIG=~/.kube/config
alias k=kubectl
alias -g aall="clusterrolebindings,clusterroles,configmaps,cronjobs,customresourcedefinitions,daemonsets,deployments,externalmetrics,horizontalpodautoscalers,ingresses,jobs,persistentvolumeclaims,persistentvolumes,poddisruptionbudgets,podmonitors,pods,podsecuritypolicies,podtemplates,replicasets,rolebindings,roles,secrets,serviceaccounts,servicemonitors,services,statefulsets,storageclasses,volumeattachments"
function get-kubeconfig {
    aws eks update-kubeconfig \
	--region $AWS_DEFAULT_REGION \
	--name $1 \
	--alias $1
}
function kls { kubectl config get-contexts }
function ktx { kubectl config use-context $1 --namespace=$2 }



function sshkey {
    cat ~/.ssh/id_rsa.pub | ssh $1 'mkdir ~/.ssh; chmod 0700 ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 0600 ~/.ssh/authorized_keys'
}
function delsshkey {
    sed -i.bak "$1d" ~/.ssh/known_hosts
}

alias -g C='| cat'
alias -g L='| less -R'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g SL=' | sort -n | less'
alias -g eo='2>&1'
alias -g cdl='| colordiff -Bbwu | less'

export CLICOLOR_FORCE=1

alias python=python3
alias pipenv=$(python -m site --user-base)/bin/pipenv
alias vup=". ./venv/bin/activate"
alias vdown=deactivate
alias vnew='python3 -mvenv venv'
alias pup='pip install --upgrade pip && pip install --upgrade setuptools'
function vpip {
    [[ -e requirements.txt ]] && pip install -r requirements.txt
    [[ -e build-requirements.txt ]] && pip install -r build-requirements.txt
}   

alias -g dl='$(docker ps -laq)'
alias dla='docker ps -a'
alias -g dli='$(docker images -q | head -1)'

alias weather='docker run jess/weather'
alias exifdate='mdls -name kMDItemContentCreationDate '


alias td='tree -d'
alias td1='td -L 1'
alias td2='td -L 2'
alias td3='td -L 3'
alias t='tree -I venv'
alias t1='tree -I venv -L 1'
alias t2='tree -I venv -L 2'
alias t3='tree -I venv -L 3'

export GITHUB_EMAIL=cdemarco@gmail.com

export CLUSTER_REGION=us-west-2

alias aws-which='aws sts get-caller-identity | jq -r .Arn'
alias manticore-which='set | egrep "(CLUSTER_REGION|STATE_REGION|ACCOUNT|ENV|CLUSTER_COLOR)"'

# lookup an aws ec2 instance by its private ip
function instancebyprivateip {
    aws ec2 describe-instances \
	--filter Name=private-ip-address,Values=${1} | \
	jq -r '.Reservations[].Instances[].InstanceId'
}

function  start-ssm { aws ssm start-session --target $1 }

function github {
    git config --global user.email $GITHUB_EMAIL
    git config --global credential.username $GITHUB_EMAIL
}
function gitlab {
    git config --global user.email cmd@alephant.net
    git config --global credential.username cmd@alephant.net
}

function autosave-git {
    msg=${1:-Autosave}
       
    git pull && \
	git ci -am "$msg" && \
	git push
}
alias -g GP=' && git push'


function pastxt { pbpaste > $1.txt ; cat $1.txt }


