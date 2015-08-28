# dotfiles
TODO: properly externalize other git repos within .emacs.d/

## Installation

Clone the git repo: 

    mkdir -p cmd/src
	git clone https://github.com/christopher-demarco/dotfiles.git
	git submodule update --init
	

Then use [homemaker](http://foosoft.net/projects/homemaker/) to deploy.

Linux: 
    
    ./homemaker_x86 ./homemaker.tml .

OSX: 

Install go. Then

    go get github.com/FooSoft/homemaker
	

## Customization

I've forked oh-my-zsh and made a custom theme. It remains to be seen whether pulling changes from master (what's the Git terminology for that!?) is too hairy.



*Copyright (c) 2015 Christopher DeMarco <<cdemarco@gmail.com>>. All rights reserved.*
