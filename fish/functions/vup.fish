function vup
    if test -d venv
        source venv/bin/activate.fish
    else if test -d .venv
        source .venv/bin/activate.fish
    end
end
