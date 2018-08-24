#export TERM=xterm-256color # iterm2 takes care of this?

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mortalscumbag-cmd"

DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git)


export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$HOME/cmd/src/go/bin:$HOME/cmd/proxy"

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
if [ -e /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
    EMACS="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
    #EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
fi

# TODO: This is completely and totally non-portable
# It's also ugly and stupid
# But I'm lazy
export EDITOR="TERM=xterm-24bits $EMACS -nw"
export GIT_EDITOR="TERM=xterm-24bits $EMACS -nw"
alias tmacs="TERM=xterm-24bits tmux new -s emacs"
alias em="TERM=xterm-24bits $EMACS -nw"


alias ssh='ssh -v'
alias ssho='ssh -o ProxyCommand="ssh -W %h:%p -q demarco@office.rhiza.com"'


alias sl=ls
if [[ $(uname) == 'Darwin' ]] ; then
    alias ls='ls -FhG'
else
    alias ls='ls -Fh --color=yes'
fi
alias svnst="svn st | egrep -v '^(X|$|Performing)'"
alias cg='egrep -v "^($|[[:space:]]*#|;)" ' # strip out comments
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias his='history'
alias hgrep='his | grep'
alias crasshplan='ssh -v -L 4200:localhost:4243'
alias screenssharing="ssh -L 31337:localhost:5900 "
alias cld='colordiff -Bbwu'


### tmux
alias tls='tmux ls'
alias tm='tmux'
alias tn='tmux new-session -s '
alias tnew='tmux new-session -s '
alias ta='tmux attach -t '
alias tattach='tmux attach -d -t '
alias tcd='tmux attach -c $PWD -t '


alias ansible-init='. ./venv/bin/activate; source ansible/hacking/env-setup; export EC2_INI_PATH=inventory/ec2.ini; export ANSIBLE_HOST_KEY_CHECKING=False'
alias tf=terraform
alias tfgrep 'grep -v tfstate'
alias k=kubectl
export GOPATH=$HOME/cmd/src/go
export GEM_PATH=$HOME/.gems:/usr/lib/ruby/gems/2.0.0


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
alias -g eo='2>&1'

export CLICOLOR_FORCE=1


alias pipenv=$(python -m site --user-base)/bin/pipenv
export PYTHONPATH=$PYTHONPATH:~/rhiza/rhiza/asgard/shared
alias vup=". ./venv/bin/activate"
alias vdown=deactivate
alias vnew='python3 -mvenv venv'
alias pup='pip install --upgrade pip && pip install --upgrade setuptools'
alias vpip='pip install -r requirements.txt'


alias -g dl='$(docker ps -laq)'
alias dla='docker ps -a'
alias -g dli='$(docker images -q | head -1)'


function essh { ssh -i ~/.ssh/gotham2.pem ec2-user@$1 }

alias weather='docker run jess/weather'

alias ts='tig status'

alias td='tree -d'
alias td1='td -L 1'
alias td2='td -L 2'
alias td3='td -L 3'

function legacy_ufw {
    for ip in $(tf output cidrs); do
        ip=$(echo $ip | cut -d/ -f1)
        echo sudo ufw insert 1 allow proto tcp from $ip to any port 3306
    done
    for ip in $(dig +short rhiza-hq.rhizalytics.com) $(dig +short jenkins.rhizalytics.com) $(dig +short hydrogen.rhizalytics.com); do
        echo sudo ufw insert 1 allow from $ip to any 
    done
}
function legacy_iptables {
    for ip in $(tf output cidrs) $(dig +short rhiza-hq.rhizalytics.com) $(dig +short jenkins.rhizalytics.com) $(dig +short hydrogen.rhizalytics.com) 206.210.65.20 52.90.22.241; do
        ip=$(echo $ip | cut -d/ -f1)
        echo sudo iptables -I INPUT -p tcp --dport 3306 -s $ip -j ACCEPT
    done
    echo sudo iptables -A INPUT -p tcp --dport 3306 -j DROP
}


function mtmux {
    aws s3 sync s3://rhiza_ansible/metropolis/$1/metropolis-${1}.tmuxinator.yml/ ~/.tmuxinator/
    tmuxinator metropolis-${1}
}

alias exifdate='mdls -name kMDItemContentCreationDate '

alias pushwiki='git pull && git ci -am 'd' && git push'
alias cdwiki='cd ~/rhiza/wiki'
