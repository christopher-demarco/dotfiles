function kbuild --wraps='kustomize build' --description 'alias kbuild=kustomize build'
  kustomize build $argv; 
end
