export TERM=xterm-256color

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

#ZSH_THEME=muse
#ZSH_THEME="robbyrussell"
ZSH_THEME="mortalscumbag-cmd"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:~/cmd/src/go/bin:~/cmd/proxy"

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


# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

EMACS=$(which emacsclient)
if [ -e /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
    EMACS="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
    #EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
fi
export EDITOR="$EMACS -nw"
export GIT_EDITOR="$EMACS -nw"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
alias ssh='ssh -v'
## proxy through office.rhiza.com
alias ssho='ssh -o ProxyCommand="ssh -W %h:%p -q demarco@office.rhiza.com"'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
alias sl=ls
alias ls='ls -FhG'
alias svnst="svn st | egrep -v '^(X|$|Performing)'"
alias em="$EMACS -nw"
alias EM="$EMACS"
alias cg='egrep -v "^($|[[:space:]]*#|;)" ' # strip out comments
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias his='history'
alias hgrep='his | grep'
alias crasshplan='ssh -v -L 4200:localhost:4243'
alias screenssharing="ssh -L 31337:localhost:5900 "


### tmux
alias tls='tmux ls'
alias tm='tmux'
alias tn='tmux new-session -s '
alias tnew='tmux new-session -s '
alias ta='tmux attach -t '
alias tattach='tmux attach -d -t '


### Ansible
alias ansible-init='workon ansible; source ~/rhiza/EngOps/ansible/ansible/hacking/env-setup; export EC2_INI_PATH=inventory/ec2.ini'

### Hashicorp
alias tf=terraform

### Go
export GOPATH=$HOME/cmd/src/go
export GEM_PATH=$HOME/.gems:/usr/lib/ruby/gems/2.0.0

### SSH
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
alias -g hq='50.202.194.218'

alias dirs='dirs -v'

alias irssi='TERM=screen-256color irssi'

export CLICOLOR_FORCE=1

### Python
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh # sudo pip install virtualenvwrapper



### Docker
alias -g dl='$(docker ps -laq)'
alias dla='docker ps -a'
alias -g dli='$(docker images -q | head -1)'

### Eternia
function essh { ssh -i ~/.ssh/gotham2.pem ec2-user@$1 }

alias weather='docker run jess/weather'

alias ts='tig status'

alias td='tree -d'
alias td1='td -L 1'
alias td2='td -L 2'


# So backward-compatible aliases should be in a .bash_aliases. In
# fact, there should be a bash_common.sh which has everything for both
# shells, and .zshrc only overrides.

