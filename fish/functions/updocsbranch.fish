function updocsbranch
cd ~/drw/up/documentation/main
git pull
git worktree add ../$argv[1]
cd ../$argv[1]/internal/teams/platform-infrastructure
end
