function cg
    egrep -v "^(%|[[:space:]]*#|;)" $argv[1]
end
