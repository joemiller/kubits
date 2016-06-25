class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'todo'
  #url 'https://github.com/pantheon-systems/kubits/archive/v0.0.1.tar.gz'
  #sha256 'todo'
  url 'git@github.com:pantheon-systems/kubits.git',
    tag: 'v0.0.1' #,
    #revision: "30cd70a45b6659ad9c571468ae6c49f38142dd5f"

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
