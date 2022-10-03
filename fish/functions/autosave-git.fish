function autosave-git
    if test $argv[1]
	set msg $argv[1]
    else
	set msg "Autosave"
    end
    git pull
    git ci -am "$msg"
    git push
end
