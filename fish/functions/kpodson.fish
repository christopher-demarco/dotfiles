function kpodson
    # Usage: kpodson [context] <node>
    set -l ctxopt
    set -l node

    switch (count $argv)
        case 2
            set ctxopt --context=$argv[1]
            set node $argv[2]
        case 1
            set node $argv[1]
        case '*'
            echo "Usage: kpodson [context] <node>" >&2
            return 1
    end

    kubectl $ctxopt get pods -A --field-selector spec.nodeName=$node
end
