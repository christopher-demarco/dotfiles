function cla
    if test (count $argv) -ge 1
        set -f id $argv[1]
    else
        set -f id (go run github.com/hatemosphere/random-name-generator-cli@latest)
    end

    set -l dir ~/.local/share/claude-sessions/$id
    mkdir -p $dir
    cd $dir
    tmux new-session -s $id "claude"
end
