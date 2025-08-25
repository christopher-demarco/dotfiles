if status is-interactive
    # Commands to run in interactive sessions can go here
end

[ (uname) = "Darwin" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
    end
end
# <<< conda initialize <<<

[ -e /opt/homebrew/opt/asdf/libexec/asdf.fish ] && . /opt/homebrew/opt/asdf/libexec/asdf.fish
[ -e ~/.work.fish ] && . ~/.work.fish


fish_add_path $HOME/go/bin
fish_add_path $HOME/.config/emacs/bin
fish_add_path $HOME/bin

set -Ux EDITOR "emacsclient -nw"
set -Ux VISUAL "emacsclient -nw"

command -v starship >/dev/null 2>&1 && starship init fish | source

direnv hook fish | source
command -v starship >/dev/null 2>&1 && eval "$(devbox global shellenv)"

function fish_user_key_bindings
  bind ctrl-alt-h backward-kill-word
end

# Added by Windsurf
fish_add_path /Users/cdemarco/.codeium/windsurf/bin

# Added by `rbenv init` on Wed Aug  6 15:42:25 EDT 2025
status --is-interactive; and rbenv init - --no-rehash fish | source
