function kbuilddiff
kbuild $argc[1] | k diff -f - | colordiff | less -R
end
