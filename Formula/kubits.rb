class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'https://github.com/joemiller/kubits'
  url 'https://github.com/joemiller/kubits/archive/v0.0.7.tar.gz'
  sha256 '73322e477cae0add3b38f70eb8c619b9bb578f9e7dfdd0c22bdedfb8cbede754'

  # head 'https://github.com/joemiller/kubits.git'

  bottle :unneeded

  def install
    bin.install 'kube-cluster'
    bin.install 'kube-ns'
    bin.install 'kube-tail'
    zsh_completion.install 'completions/zsh/_kube-cluster.sh'
    zsh_completion.install 'completions/zsh/_kube-ns.sh'
    bash_completion.install 'completions/bash/_kube-cluster.sh'
    bash_completion.install 'completions/bash/_kube-ns.sh'
  end

  test do
    system "#{bin}/kube-cluster"
  end
end
