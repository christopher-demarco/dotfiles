function kbuilddiff
  set -x KUBECTL_EXTERNAL_DIFF /Users/cdemarco/bin/kubectl-diff-no-argo.sh
  kbuild $argc[1] | k diff -f - | colordiff | less -R
end
