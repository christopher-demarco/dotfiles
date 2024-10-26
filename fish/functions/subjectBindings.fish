function subjectBindings
k get clusterrolebinding,rolebinding -A -o yaml | yq '.items[] | select(.subjects[].name=="argo*") | ({"subjects": .subjects[].name, "roleRef": .roleRef})'
end
