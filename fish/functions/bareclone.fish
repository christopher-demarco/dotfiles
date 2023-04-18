function bareclone
git clone --bare $argv .bare
echo gitdir: ./.bare > .git
git worktree add master
end
