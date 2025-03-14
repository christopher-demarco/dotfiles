function updocsbranch
cd ~/up-docs/main
git pull
git worktree add ../$argv[1]
cd ../$argv[1]/pages/platform-infrastructure
end
