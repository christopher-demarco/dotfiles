# dotfiles
TODO: properly externalize other git repos within .emacs.d/

## Installation

Clone the git repo: 

```
mkdir -p cmd/src; cd cmd/src
git clone https://github.com/christopher-demarco/dotfiles.git
cd dotfiles
git submodule update --init

```	

Then use [homemaker](http://foosoft.net/projects/homemaker/) to deploy.

Linux: 
```    
git checkout linux
cd ~/cmd/src/dotfiles; ./homemaker_x64 ./homemaker.tml .

```

OSX: 

Install go. Then

```
export GOPATH=$HOME/cmd/src/go 
mkdir -p $GOPATH
go get github.com/FooSoft/homemaker
homemaker $HOME/cmd/src/dotfiles/homemaker.tml $HOME/cmd/src/dotfiles
```


## Customization

I've forked oh-my-zsh and made a custom theme. It remains to be seen whether pulling changes from master (what's the Git terminology for that!?) is too hairy.



## Dark Mode / Tmux Theme Sync

`com.cdemarco.dark-notify-tmux.plist` is a launchd service that watches for macOS dark/light mode changes and updates the tmux theme accordingly via `dark-notify-tmux.sh`.

**Prerequisites:** `brew install cormacrelf/tap/dark-notify`

**Install:**

```sh
cp com.cdemarco.dark-notify-tmux.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.cdemarco.dark-notify-tmux.plist
```

**Reload after changes:**

```sh
launchctl unload ~/Library/LaunchAgents/com.cdemarco.dark-notify-tmux.plist
launchctl load ~/Library/LaunchAgents/com.cdemarco.dark-notify-tmux.plist
```

The service starts automatically at login and stays alive.


*Copyright (c) 2021 Christopher DeMarco <<cdemarco@gmail.com>>. All rights reserved.*
