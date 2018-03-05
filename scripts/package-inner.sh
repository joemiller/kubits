#!/bin/bash
#
# Requires: PKG_TYPE= (rpm | deb)
# Outputs: packages in ./pkg

#set -x
set -e

# get the closest tag and use it as pkg version.
# TODO: in the future, consider pushing every build even if not tagged to an 'autobuild' repo
version=$(git describe --abbrev=0 --tags | sed -e 's/^v//')
iteration="git$(git rev-parse --short HEAD)"
package_type=$PKG_TYPE
architecture='noarch'
url='https://github.com/joemiller/kubits'
description='Collection of utilities for better Kubernetes workflows.'

share_dir=/usr/local/share/kubits
bin_dir=/usr/local/bin
bash_completion_dir=/usr/share/bash-completion/completions
zsh_completion_dir=/usr/share/zsh-site-functions

# because fpm lacks an option for "write package to a specific ./directory":
mkdir -p ./pkg
cd ./pkg

# Package it
fpm -s dir \
    -t "${package_type}" \
    --force \
    --name "kubits" \
    --version "${version}" \
    --iteration "${iteration}" \
    --architecture "${architecture}" \
    --url "${url}" \
    --description "${description}" \
    ../kubectl-plugins=${share_dir}/ \
    ../kube-cluster=${bin_dir}/kube-cluster \
    ../kube-dash=${bin_dir}/kube-dash \
    ../kube-ns=${bin_dir}/kube-ns \
    ../kube-tail=${bin_dir}/kube-tail \
    ../completions/bash/_kube-cluster.sh=${bash_completion_dir}/ \
    ../completions/bash/_kube-ns.sh=${bash_completion_dir}/ \
    ../completions/zsh/_kube-cluster.sh=${zsh_completion_dir}/ \
    ../completions/zsh/_kube-ns.sh=${zsh_completion_dir}/
