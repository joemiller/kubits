kubits
======

Collection of utilities to improve working with Kubernetes clusters.

NOTE: This is currently a private github repo, though there is nothing specific
to Pantheon or sensitive in it. It might be easier to make this a public repo.

Install
-------

### macOS:

Because this is a private github repo, we need to use the brew-tap form: `brew tap user/repo URL`
where `URL` is the ssh URL to this repo.

    $ brew tap pantheon-systems/kubits git@github.com:pantheon-systems/kubits.git
    $ brew install pantheon-systems/kubits/kubits --HEAD

Upgrading:

    $ brew update
    $ brew uninstall pantheon-systems/kubits/kubits
    $ brew install pantheon-systems/kubits/kubits --HEAD

### Linux:

TODO

Uninstall
---------

### macOS:

    $ brew uninstall pantheon-systems/kubits/kubits
    $ brew untap brew uninstall pantheon-systems/kubits

Usage
-----

### kube-cluster

List and set the current kubernetes cluster:

    $ kube-cluster
    foo
    bar

    $ kube-cluster foo
    switched to context "foo"

### kube-ns

List and set the current namespace:

    $ kube-ns
    NAME          STATUS    AGE
    default       Active    70d
    development   Active    70d
    production    Active    70d

    $ kube-ns development

BASH / ZSH completion
---------------------

Completion helpers are available for both BASH and ZSH in the `./completions` directory.
These are installed automatically when installing via homebrew.
