_kube-ns() { compadd $(kube-ns | awk '/Active/ {print $1}') }
compdef _kube-ns kube-ns
