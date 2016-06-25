class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'todo'
  url 'https://github.com/pantheon-systems/kubits/archive/v0.0.1.tar.gz'
  sha256 'todo'

	head "https://github.com/pantheon-systems/kubits.git"

  bottle :unneeded

  def install
    bin.install 'kube-cluster'
    bin.install 'kube-ns'
    zsh_completion.install 'completions/zsh/_kube-cluster.sh'
    zsh_completion.install 'completions/zsh/_kube-ns.sh'
    bash_completion.install 'completions/bash/_kube-cluster.sh'
    bash_completion.install 'completions/bash/_kube-ns.sh'
  end

  test do
    system "#{bin}/kube-cluster"
  end
end
