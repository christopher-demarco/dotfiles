# Completions for ta (tmux attach) function
complete -c ta -f -a "(tmux list-sessions -F '#S' 2>/dev/null)"
