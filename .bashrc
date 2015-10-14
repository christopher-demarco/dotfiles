# First things first: are we on a Mac?
MAC=no; uname | grep -q Darwin; [ $? -eq 0 ] && MAC=yes

# source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc


# Fix backspace/delete
if [ "$PS1" ] && [ $TERM != "emacs" ] && [ -x /usr/bin/tput ] && \
    [ "x$(tput kbs)" != "x" ]; then 
    stty erase ^H
    stty erase $(tput kbs)
fi


# Set PROMPT_COMMAND, but only if $TERM is xterm-like 
case $TERM in
    "linux" | "dumb" | "emacs")
        true
        ;;
    *)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
esac


# # ## ### ##### ######## ############# #####################
# # Look-n-feel
# use_color=false
# safe_term=${TERM//[^[:alnum:]]/.}       # sanitize TERM

# # A good guess of whether this $TERM can display color
# if [[ -f /etc/DIR_COLORS ]] ; then
#         grep -q "^TERM ${safe_term}" /etc/DIR_COLORS && use_color=true
# elif type -p dircolors >/dev/null ; then
#         if dircolors --print-database | grep -q "^TERM ${safe_term}" ; then
#                 use_color=true
#         fi
# elif [ $TERM == xterm-color ]; then
#     use_color=true
# fi
use_color=true

# So now go ahead and randomize the color of the prompt
function returncode { # Useful to know whether something failed!
  returncode=$?
    if [ $returncode != 0 ]; then
        echo "[$returncode]"
    else
        echo ""
    fi
}
if ${use_color} ; then
    COLORS=(30 32 33 34 35 36 37)
    n=$(($RANDOM % ${#COLORS[*]}))
    b=$(($RANDOM % 2))
    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[01;31m\]$(returncode)\[\033[01;31m\]\h \[\033[01;34m\]\W \$ \[\033[00m\]'
    else
        PS1='\[\033[${b};31m\]$(returncode)'"\[\033[01;${COLORS[n]}m\]\u@\h \[\033[01;34m\]\w \$ \[\033[00m\]"
    fi
else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='$(returncode)\u@\h \W \$ '
    else
        PS1='$(returncode)\u@\h \w \$ '
    fi
fi


# Bell too loud?  Too ugly?
if [ $TERM == "linux" ] ; then
    setterm -blength 5 -bfreq 100
fi

export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m' 
export PAGER="less -R"
alias less='less -R' # better than -r

# and grep
if [ $MAC == 'yes' ]; then
    _true=/usr/bin/true
else
    _true=/bin/true
fi
grep  --color=yes 1 $_true  >/dev/null 2>&1
if ! [ $? -gt 0 ] && [ $TERM != 'dumb' ]; then
    export GREP_COLOR='01;33'
    alias grep='grep --color=yes'
fi

# and ls
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
case $TERM in
	"emacs" | "dumb")
        alias ls='ls --color=no -Fh'
	    ;;
	*)
        alias ls='ls --color=yes -Fh'
	    ;;
esac
[ $MAC == 'yes' ] && alias ls='ls -FhG'

umask 0077


# # ## ### ##### ######## ############# #####################
# # env variables

export LOCALE=en_us
export LANG=C

EMACS=$(which emacs)
if [ -e /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
     EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
#    EMACS="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
fi
alias emacs=$EMACS

export EDITOR="$EMACS"
export VISUAL=$EDITOR

unset USERNAME

if [ -a /proc/cpuinfo ]; then
    export CONCURRENCY_LEVEL=$(($(grep -c processor /proc/cpuinfo) * 2 + 1))
    export MAKEOPTS="-j${CONCURRENCY_LEVEL}"
fi


export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONPATH="/$HOME/lib"
# # sudo -H pip install virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs # mkvirtualenv someproject
# source /usr/local/bin/virtualenvwrapper.sh

export JAVA_HOME=/usr

export GEM_PATH=$HOME/.gems:/usr/lib/ruby/gems/2.0.0

export GOPATH=$HOME/cmd/src/go

export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$GOPATH/bin

# # ## ### ##### ######## ############# #####################
# # aliases

alias sl='ls'
alias svnst="svn st | egrep -v '^(X|$|Performing)'"
alias svndiff="svn diff | less"
alias svnurl="svn info | grep URL | cut -d' ' -f2 | pbcopy"
alias ipgrep='egrep -o "(([0-9]{1,3}\.){3}[0-9]{1,3})"' # iptables -L|ipgrep
alias rot13='tr A-Za-z N-ZA-Mn-za-m' # sbe terng whfgvpr
alias cg='egrep -v "^($|[[:space:]]*#|;)" ' # strip out comments
##alias ssh='ssh -v'

# Since sliced bread
alias dirs='dirs -l -p'
alias pushd='pushd >/dev/null'
alias popd='popd >/dev/null'

# Safety First
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Easily print plaintext
alias enscript='enscript -B --font=Courier6'

# Wait... what?
alias his='history'
alias hgrep='his | grep'


# # ## ### ##### ######## ############# #####################
# # functions

function sshkey {
    if [ -e ~/.ssh/id_dsa.pub ] ; then
	keyfile=id_dsa.pub
    elif [ -e ~/.ssh/id_rsa.pub ] ; then
	keyfile=id_rsa.pub
    fi
    cat ~/.ssh/${keyfile} | ssh $1 'mkdir ~/.ssh; chmod 0700 ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 0600 ~/.ssh/authorized_keys'
}


# inverse viagra to compete with vi and ed 
alias em="$EMACS"

# Did you ever wonder whether an IP is *really* retired?
function otf {
    H=$1
    echo "pinging..."
    answer=$(ping -c 3 $H 2>&1)
    if [ $? -eq 0 ]; then
        echo "$answer"
        return 0
    fi
    echo "arpinging..."
    answer=$(arping -c 3 $H 2>&1)
    if [ $? -eq 0 ]; then
        echo "$answer"
        return 0
    fi
    echo "portscanning..."
    answer=$(sudo scanrand $H:all 2>&1)
    if [ "${answer}foo" != "foo" ]; then
        echo "$answer"
        return 0
    fi
    echo "$H is not alive."
    return 1
}


# Handy for when you don't have a GUI
walkback() {
    f=$1
    n=$m
    m=$(($m - 1))
    svn diff -r${m}:${n} $f
}

# Likewise
findword() {
    for f in \
        $(find . -type f | \
        grep -v .svn); do \
        file $f | grep -q text && grep -iH $1 $f; \
        done

}


# SSH tunnel for connecting to CrashPlan client GUI
alias crasshplan='ssh -v -L 4200:localhost:4243'
alias crashplan='open /Applications/CrashPlan.app'


alias screenssharing="ssh -L 31337:localhost:5900 "

function delsshkey {
    sed -i.bak "$1d" ~/.ssh/known_hosts
}

function pidof {
    ps -Ac | egrep -i $@ | awk '{ print $1 }'
}

function svnstamp {
    if [ ! -e $1 ]; then
	echo "File $1 not found."
	return
    fi
    svn ps 'svn:keywords' 'IdURL' $1
    echo '# $Id$' >> $1
    echo '# $URL$' >> $1
}
