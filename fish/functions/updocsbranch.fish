function updocsbranch
cd ~/up-docs/main
git pull
git worktree add ../$argv[1]
cd ../$argv[1]/content
end
