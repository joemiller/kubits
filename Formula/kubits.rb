class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'todo'
  url 'git@github.com:pantheon-systems/kubits.git',
    using: :git,
    tag: 'v0.0.2'

	head 'https://github.com/pantheon-systems/kubits.git'

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
