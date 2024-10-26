function bareclone
    git clone --bare $argv .bare
    echo gitdir: ./.bare > .git
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch origin
    git worktree add main
end
