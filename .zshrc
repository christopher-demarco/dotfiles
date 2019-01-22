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

alias ssh='ssh -v'
alias sl=ls
alias cg='egrep -v "^($|[[:space:]]*#|;)" ' # strip out comments
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias his='history'
alias hgrep='his | grep'

alias tls='tmux ls'
alias tm='tmux'
alias tn='tmux new-session -s '
alias tnew='tmux new-session -s '
alias ta='tmux attach -t '
alias tattach='tmux attach -d -t '
alias tcd='tmux attach -c $PWD -t '

alias ansible-init='. ./venv/bin/activate; source ansible/hacking/env-setup; export EC2_INI_PATH=inventory/ec2.ini; export ANSIBLE_HOST_KEY_CHECKING=False'
alias tf=terraform
alias -g tfgrep='grep -v terraform.tfstate'

export GOPATH=$HOME/cmd/src/go
export GEM_PATH=$HOME/.gems:/usr/lib/ruby/gems/2.0.0

alias k=kubectl
alias kshell='cd ~/rhiza/rhiza; VAULT_GITHUB_TOKEN=c6061c86d75f95040c3bcbe5d3df406447c35982 asgard/build/images/k8s/run.sh $PWD'


function sshkey {
    cat ~/.ssh/id_rsa.pub | ssh $1 'mkdir ~/.ssh; chmod 0700 ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 0600 ~/.ssh/authorized_keys'
}
function delsshkey {
    sed -i.bak "$1d" ~/.ssh/known_hosts
}

alias -g L='| less -R'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g SL=' | sort -n | less'
alias -g eo='2>&1'
alias -g cld='colordiff -Bbwu'

export CLICOLOR_FORCE=1

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
alias ts='tig status'

alias td='tree -d'
alias td1='td -L 1'
alias td2='td -L 2'
alias td3='td -L 3'

# Rhiza
function mtmux {
    aws s3 sync s3://rhiza_ansible/metropolis/$1/metropolis-${1}.tmuxinator.yml/ ~/.tmuxinator/
    tmuxinator metropolis-${1}
}

export KUBECONFIG=~/rhiza/rhiza/ops/EngOps/terraform/eks/kubeconfig

alias pushwiki='git pull && git ci -am 'd' && git push'
alias ciwiki='git pull && tig status'
alias -g wiki='~/rhiza/wiki'
alias cdwiki='cd ~/rhiza/wiki'
export PYTHONPATH=~/rhiza/rhiza/asgard/shared:~/rhiza/rhiza/asgard/build

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
