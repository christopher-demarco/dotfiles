function kpodson
kubectl get pods -A --field-selector spec.nodeName=$argv[1]

end
