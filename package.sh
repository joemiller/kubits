#!/bin/bash
set -eou pipefail

# Define the package metadata
if [ -z "${VERSION:-}" ]; then
  VERSION='dev'
fi

package_type=$PKG_TYPE
version=$VERSION
iteration="git$(git rev-parse --short HEAD)"
architecture='x86_64'
url="https://github.com/joemiller/kubits"
description="Collection of utilities to improve working with Kubernetes clusters."

# Create symlink to include in package.
mkdir -p ./tmp
mkdir -p ./tmp/zsh
mkdir -p ./tmp/bash
ln -s /usr/lib/kubits/kube-ns ./tmp/kube-ns
ln -s /usr/lib/kubits/kube-cluster ./tmp/kube-cluster
ln -s /usr/lib/kubits/kube-dash ./tmp/kube-dash
ln -s /usr/lib/kubits/kube-tail ./tmp/kube-tail
ln -s /usr/lib/kubits/completions/zsh/_kube-ns.sh ./tmp/zsh/_kube-ns
ln -s /usr/lib/kubits/completions/zsh/_kube-cluster.sh ./tmp/zsh/_kube-cluster
ln -s /usr/lib/kubits/completions/bash/_kube-ns.sh ./tmp/bash/_kube-ns
ln -s /usr/lib/kubits/completions/bash/_kube-cluster.sh ./tmp/bash/_kube-cluster


# Package it
fpm -s dir -t "${package_type}" \
    --name "kubits" \
    --version "${version}" \
    --iteration "${iteration}" \
    --architecture "${architecture}" \
    --url "${url}" \
    --description "${description}" \
    ../kubits=/usr/lib \
    ./tmp/kube-ns=/usr/bin \
    ./tmp/kube-cluster=/usr/bin \
    ./tmp/kube-dash=/usr/bin \
    ./tmp/kube-tail=/usr/bin \
    ./tmp/zsh/_kube-ns=/usr/share/zsh/site-functions \
    ./tmp/zsh/_kube-cluster=/usr/share/zsh/site-functions \
    ./tmp/bash/_kube-ns=/usr/share/bash-completion/completions \
    ./tmp/bash/_kube-cluster=/usr/share/bash-completion/completions
