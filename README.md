kubits
======

Collection of utilities to improve working with Kubernetes clusters.

NOTE: This is currently a private github repo, though there is nothing specific
to Pantheon or sensitive in it. It might be easier to make this a public repo.

Install
-------

### macOS:

Because this is a private github repo, we need to use the brew-tap form
`brew tap user/repo URL` where `URL` is the ssh URL to this repo:

    $ brew tap pantheon-systems/kubits git@github.com:pantheon-systems/kubits.git
    $ brew install pantheon-systems/kubits/kubits

Upgrading:

    $ brew update
    $ brew upgrade pantheon-systems/kubits/kubits

### Linux:

TODO

Uninstall
---------

### macOS:

    $ brew uninstall pantheon-systems/kubits/kubits
    $ brew untap pantheon-systems/kubits

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
2. Edit `Formula/kubits.rb` bump version in `tag:`
3. Make your edits, commit them: `git commit -a`
4. Create new version tag: `git tag v0.0.4` (this must match the tag: in `Formula/kubits.rb`)
5. Push your branch: `git push origin feature-name`
6. Open a pull request, get code review, merge to master
7. After merged to master, you can test your update is available by running the
   upgrade procedure: `brew update && brew upgrade pantheon-systems/kubits/kubits`

Only bumping version:

1. Edit `./Formula/kubits.rb` update `tag`, eg `v0.0.4`
2. Make git tag: `git tag v0.0.4`
3. Push tag: `git push --tags`

TODO
----

- [ ] include helpers for adding cluster+namespace to bash and zsh prompts
- [ ] add circle-ci? add shellcheck for linting?
