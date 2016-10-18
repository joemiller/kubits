class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'https://github.com/joemiller/kubits'
  url 'git@github.com:joemiller/kubits.git',
    using: :git,
    tag: 'v0.0.6'

  # TODO: when we switch to a public github repo, use https tarball url method instead, example:
  #   url 'https://github.com/joemiller/kubits/archive/v0.0.5.tar.gz'
  #   sha256 '...checksum here...'

  head 'https://github.com/joemiller/kubits.git'

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
