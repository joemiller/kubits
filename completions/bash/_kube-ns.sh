complete -W "$(kube-ns kube-ns | awk '/Active/ {print $1}')" kube-ns
