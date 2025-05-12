if status is-interactive
    # Commands to run in interactive sessions can go here
end

[ (uname) = "Darwin" ] && eval "(/opt/homebrew/bin/brew shellenv)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

[ -e /opt/homebrew/opt/asdf/libexec/asdf.fish ] && . /opt/homebrew/opt/asdf/libexec/asdf.fish
[ -e ~/.drw.fish ] && . ~/.drw.fish
[ -e ~/.sgpt_vars.fish ] && . ~/.sgpt_vars.fish

fish_add_path $HOME/go/bin
fish_add_path $HOME/.config/emacs/bin

set -Ux EDITOR "emacsclient -nw"
set -Ux VISUAL "emacsclient -nw"

starship init fish | source
function fish_user_key_bindings
  bind ctrl-alt-h backward-kill-word
end
