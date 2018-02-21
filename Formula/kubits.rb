class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'https://github.com/joemiller/kubits'
  url 'https://github.com/joemiller/kubits/archive/v0.0.10.tar.gz'
  sha256 '0a7a4b52324fb4e2a2c5ec9b7f9a1de7757a3dc7c51ad68068df886d2f9241bb'

  # head 'https://github.com/joemiller/kubits.git'

  bottle :unneeded

  def install
    bin.install 'kube-cluster'
    bin.install 'kube-ns'
    bin.install 'kube-tail'
    bin.install 'kube-dash'
    zsh_completion.install 'completions/zsh/_kube-cluster.sh'
    zsh_completion.install 'completions/zsh/_kube-ns.sh'
    bash_completion.install 'completions/bash/_kube-cluster.sh'
    bash_completion.install 'completions/bash/_kube-ns.sh'
  end

  test do
    system "#{bin}/kube-cluster"
  end
end
