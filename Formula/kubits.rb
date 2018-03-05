class Kubits < Formula
  desc 'utilities for working kubernetes clusters'
  homepage 'https://github.com/joemiller/kubits'
  url 'https://github.com/joemiller/kubits/archive/v0.1.0.tar.gz'
  sha256 'e34fd566a1041626a2243eb9ce45b256b6355352c7cb65a8c7b18520f8c25507'

  # head 'https://github.com/joemiller/kubits.git'

  bottle :unneeded

  def install
    # replace '${SCRIPT_DIR}' in the kube-tail script with 'prefix', eg: '/usr/local/Cellar/kubits/0.0.11'
    # TODO(joe): better way to handle this than doing an install-time modification of the wrapper script? Something cross-platform and not brew-specific would be best.
    inreplace 'kube-tail', '${KUBITS_HOME}', prefix

    # install ./kubectl-plugins to /usr/local/Cellar/kubits/<version>/kubectl-plugins
    prefix.install 'kubectl-plugins'

    # install each cmd to /usr/local/Cellar/kubits/<version>/bin/<cmd> with symlink to /usr/local/bin/<cmd>
    bin.install 'kube-cluster'
    bin.install 'kube-ns'
    bin.install 'kube-tail'
    bin.install 'kube-dash'

    # install zsh completions to /usr/local/Cellar/kubits/<version>/share/zsh/site-functions/
    zsh_completion.install 'completions/zsh/_kube-cluster.sh'
    zsh_completion.install 'completions/zsh/_kube-ns.sh'

    # install bash completions to /usr/local/Cellar/kubits/<version>/etc/bash_completion.d/
    bash_completion.install 'completions/bash/_kube-cluster.sh'
    bash_completion.install 'completions/bash/_kube-ns.sh'
  end

  def caveats
    <<~EOS
      Once installed the 'kube-tail' utility is available as 'kube-tail' in your $PATH.
      In addition, you may want to make it available via 'kubectl plugin tail' by running the following:

      mkdir -p ~/.kubectl/plugins && ln -s "#{prefix}/kubectl-plugins/tail" ~/.kubectl/plugins/tail
    EOS
  end

  test do
    system "#{bin}/kube-cluster"
  end
end
