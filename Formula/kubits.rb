class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'https://github.com/joemiller/kubits'
  url 'https://github.com/joemiller/kubits/archive/v0.0.9.tar.gz'
  sha256 '93f0862f9aebf55acb7430cb74954e2fe17d0b5ce63b0b2221444c3277046472'

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
