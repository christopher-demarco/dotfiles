if status is-interactive
    # Commands to run in interactive sessions can go here
end

[ (uname) = "Darwin" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

[ -e /opt/homebrew/opt/asdf/libexec/asdf.fish ] && . /opt/homebrew/opt/asdf/libexec/asdf.fish
[ -e ~/.work.fish ] && . ~/.work.fish

fish_add_path $HOME/go/bin
fish_add_path $HOME/.config/emacs/bin
fish_add_path $HOME/bin
fish_add_path $HOME/cmd/src/remindme

set -Ux EDITOR "emacsclient -nw"
set -Ux VISUAL "emacsclient -nw"

command -v starship >/dev/null 2>&1 && starship init fish | source

direnv hook fish | source
command -v starship >/dev/null 2>&1 && eval "$(devbox global shellenv)"

function fish_user_key_bindings
  bind ctrl-alt-h backward-kill-word
end


# Added by `rbenv init` on Wed Aug  6 15:42:25 EDT 2025
status --is-interactive; and rbenv init - --no-rehash fish | source
