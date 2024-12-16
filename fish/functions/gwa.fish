function gwa --wraps='git worktree add' --description 'alias gwa=git worktree add'
  git worktree add $argv $argv
  if string match -q '*/*' $argv
    git worktree add $argv $argv
  else
    git worktree add $argv
  end
end
