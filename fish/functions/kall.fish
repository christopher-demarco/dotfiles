function kall
for api in (kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq)
echo "Resource: " $api
kubectl get --ignore-not-found $api
end
end
