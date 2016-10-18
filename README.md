kubits
======

Collection of utilities to improve working with Kubernetes clusters.

NOTE: This is currently a private github repo, though there is nothing specific
to Pantheon or sensitive in it. It might be easier to make this a public repo.

Install
-------

### macOS:

Install:

    $ brew install joemiller/kubits/kubits

Upgrading:

    $ brew update
    $ brew upgrade joemiller/kubits/kubits

### Linux:

TODO

Uninstall
---------

### macOS:

    $ brew uninstall joemiller/kubits/kubits
    $ brew untap joemiller/kubits

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

Developing
==========

Making changes + bumping version:

1. Make your branch: `git checkout -b feature-name`
2. Make your edits.
3. Edit `Formula/kubits.rb` bump version in `tag: 'v0.0.4'`
5. Commit everything: `git commit -a`
5. Create new tag: `git tag v0.0.4` (this must match the tag: in `Formula/kubits.rb`)
6. Push your branch: `git push origin feature-name`
7. Push your tag: `git push --tags`
8. Open a pull request, get code review, merge to master

After merge to master you can test your update is available by running the
normal upgrade procedure: `brew update && brew upgrade joemiller/kubits/kubits`

TODO
----

- [ ] include helpers for adding cluster+namespace to bash and zsh prompts
- [ ] add circle-ci? add shellcheck for linting?
- [ ] make public repo? If so, then we should switch the homebrew formula to use
      a url to the github release tarball as is common practice for most public
      brews. Also the instructions for adding the tap can be shortened to remove the URL.
