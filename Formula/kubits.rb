class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'https://github.com/joemiller/kubits'
  url 'https://github.com/joemiller/kubits/archive/v0.0.8.tar.gz'
  sha256 '10377a7a5d9dd8739a25831887e3d75a664d94a9c179559316819fdaaa87b6c4'

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
