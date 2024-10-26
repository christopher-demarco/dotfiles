function set-upstream
BRANCH=(git branch --show-current) \
git branch --set-upstream-to=origin/$BRANCH $BRANCH
end
