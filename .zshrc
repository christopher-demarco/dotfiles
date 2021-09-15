export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag-cmd"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$HOME/cmd/src/go/bin:$HOME/cmd/proxy:$HOME/cmd/bin"
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
# function tfswitch {
#     case $(basename $(ls -l /usr/local/bin/terraform | awk '{ print $NF }')) in
#         terraform_12)
#             ln -sf /usr/local/bin/terraform{_11,}
#             terraform -v
#             ;;
#         terraform_11)
#             ln -sf /usr/local/bin/terraform{_12,}
#             terraform -v
#             ;;
#         *)
#             echo "ERROR"
#             ls -l $(which terraform)
#             ;;
#     esac
#     }
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

# Rhiza
export NIELSEN_LANID=dech7001
export NIELSEN_ID=christopher.demarco@nielsen.com
export NIELSEN_EMAIL=christopher.demarco@nielsen.com
export GITHUB_EMAIL=cdemarco@gmail.com

export CLUSTER_REGION=us-west-2

. ~/rhiza/rhiza/ops/rhizacli/SOURCEME.sh

samlinator() {
    if [[ $NIELSEN_ID == "firstname.lastname@nielsen.com" ]] \
	   || [[ -z $NIELSEN_ID ]] ; then
	echo "Error: NIELSEN_ID is either unset or set wrongly in your .bashrc."
	echo -n "Enter your Nielsen email address: "
	read NIELSEN_ID
    fi
    local repo=registry.gitlab.com/nielsen-media/ma/site-reliability-engineering/samlinator
    echo "Verifying GitLab credentials . . ."
    docker login registry.gitlab.com
    echo "========================================"
    echo "Logging into Nielsen AWS . . ."
    export AWS_PROFILE=saml
    docker container run \
           -e NIELSEN_ID="$NIELSEN_ID" \
           -e AWS_PROFILE=$AWS_PROFILE \
           -v ~/.aws:/root/.aws \
           "$@" -it "$repo"
}

helminator() {
   docker login registry.gitlab.com
   local repo=registry.gitlab.com/nielsen-media/ma/site-reliability-engineering/helminator
    docker container run \
    -v ~/.kube:/root/.kube \
    -v ~/.aws:/root/.aws \
    -e CLUSTER_NAME=$CLUSTER_NAME \
    -e AWS_DEFAULT_REGION=$CLUSTER_REGION \
    -e AWS_PROFILE=$AWS_PROFILE \
    -e KUBECONFIG=/root/.kube/config \
    "$@" \
    -it $repo $@
    }


alias aws-which='aws sts get-caller-identity | jq -r .Arn'
alias manticore-which='set | egrep "(CLUSTER_REGION|STATE_REGION|ACCOUNT|ENV|CLUSTER_COLOR)"'

# lookup an aws ec2 instance by its private ip
function instancebyprivateip {
    aws ec2 describe-instances \
	--filter Name=private-ip-address,Values=${1} | \
	jq -r '.Reservations[].Instances[].InstanceId'
}

function  start-ssm { aws ssm start-session --target $1 }

function mtmux {
    aws s3 sync s3://rhiza_ansible/metropolis/$1/metropolis-${1}.tmuxinator.yml/ ~/.tmuxinator/
    tmuxinator metropolis-${1}
}
function bitbucket {
    git config --global user.email $NIELSEN_EMAIL
    git config --global credential.username $NIELSEN_LANID
}
function github {
    git config --global user.email $GITHUB_EMAIL
    git config --global credential.username $GITHUB_EMAIL
}
function gitlab-nielsen {
    git config --global user.email $NIELSEN_EMAIL
    git config --global credential.username $NIELSEN_EMAIL
    unset GIT_SSH_COMMAND
}
function gitlab {
    git config --global user.email cmd@alephant.net
    git config --global credential.username cmd@alephant.net
}

function gh2gl {
    github
    git clone --mirror https://github.com/Rhiza/${1}.git
    cd ${1}.git
    git remote set-url origin git@gitlab.com:nielsen-media/ma/rhizalytics/${1}.git
    gitlab-nielsen
    git push --mirror
    cd -
}


function autosave-org {
    msg=${1:-Autosave}
       
    git pull && \
	git ci -am "$msg" && \
	git push
}
alias -g GP=' && git push'


function pastxt { pbpaste > $1.txt ; cat $1.txt }

# function legacy_ufw {
#     for ip in $(tf output cidrs); do
#         ip=$(echo $ip | cut -d/ -f1)
#         echo sudo ufw insert 1 allow proto tcp from $ip to any port 3306
#     done
#     for ip in $(dig +short rhiza-hq.rhizalytics.com) $(dig +short jenkins.rhizalytics.com) $(dig +short hydrogen.rhizalytics.com); do
#         echo sudo ufw insert 1 allow from $ip to any 
#     done
# }
# function legacy_iptables {
#     for ip in $(tf output cidrs) $(dig +short rhiza-hq.rhizalytics.com) $(dig +short jenkins.rhizalytics.com) $(dig +short hydrogen.rhizalytics.com) 206.210.65.20 52.90.22.241; do
#         ip=$(echo $ip | cut -d/ -f1)
#         echo sudo iptables -I INPUT -p tcp --dport 3306 -s $ip -j ACCEPT
#     done
#     echo sudo iptables -A INPUT -p tcp --dport 3306 -j DROP
# }

