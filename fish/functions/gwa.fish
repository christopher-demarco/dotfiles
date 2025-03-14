function gwa --wraps='git worktree add' --description 'alias gwa=git worktree add'

  if test -d master
      cd master
  else if test -d main
      cd main
  end
  git pull
  cd -

  git worktree add $argv $argv
  if string match -q '*/*' $argv
    git worktree add $argv $argv
  else
    git worktree add $argv
  end
  cd $argv
end
