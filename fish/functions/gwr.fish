function gwr --wraps='git worktree remove' --description 'alias gwr=git worktree remove'
  git worktree remove $argv
  set -l args $argv
  if test "$args[-1]" = "--force"
    set -e args[-1]
  end
  set -x dir (dirname $args)
  test -d $dir && rmdir $dir 2>/dev/null
end
