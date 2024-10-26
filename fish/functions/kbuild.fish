function kbuild --wraps='kustomize build' --description 'alias kbuild=kustomize build'
    kustomize build \
        --load-restrictor LoadRestrictionsNone \
        --enable-helm $argv
end
