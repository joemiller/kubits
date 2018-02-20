complete -W "$(kube-ns | awk '/Active/ {print $1}')" kube-ns
