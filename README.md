kubits
======

<!-- toc -->

  * [Install](#install)
    + [macOS:](#macos)
    + [Linux:](#linux)
  * [Uninstall](#uninstall)
    + [macOS:](#macos-1)
  * [Usage](#usage)
    + [kube-cluster](#kube-cluster)
    + [kube-ns](#kube-ns)
    + [kube-tail](#kube-tail)
    + [kube-dash](#kube-dash)
  * [BASH / ZSH completion](#bash--zsh-completion)
- [Developing](#developing)
  * [Submitting changes](#submitting-changes)
  * [Updating Homebrew Formula](#updating-homebrew-formula)
  * [TODO](#todo)

<!-- tocstop -->

Collection of utilities to improve working with Kubernetes clusters.

Install
-------

### macOS:

Install:

    $ brew tap joemiller/kubits https://github.com/joemiller/kubits
    $ brew install kubits

Upgrading:

    $ brew update
    $ brew upgrade kubits

### Linux:

Installation instructions for RPM and DEB packages available on
[Packagecloud.io/joemiller/kubits](https://packagecloud.io/joemiller/kubits)

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

### kube-tail

Tail the logs from multiple pods and containers in a single command.

Each container's output is prefixed with the pod and container the originated
the log line.

Output is colored for improved readability.

Loosely inspired by the Heroku toolbelt's log tail function.

`kube-tail` accepts the same `-l | --selector` argument as `kubectl get`

    $ kubectl get pods -l app=myapp --namespace=production
    NAME                                    READY     STATUS    RESTARTS   AGE
    myapp-11345623-gj2mr                    2/2       Running   0          2d

    $ kube-tail -l app=myapp --namespace=production
    |myapp-11345623-gj2mr::nginx | 10.240.0.9 - - [18/Oct/2016:17:56:15 +0000] "GET /api/5bb0c1a8-0ad9-bcee-d3d3-f541bd3e7559/ HTTP/1.1" 200 3918 "-"
    |myapp-11345623-gj2mr::myapp | time="2016-10-18T17:36:29Z" level=info msg="New connection" clientIP=127.0.0.1:37768 conID=0dff04c5-4fa9-436c-8c08-f58d2b4e1e24

Most global options are also supported such as `--context`.

### kube-dash

Open the kubernetes-dashboard web UI of the currently configured cluster in your
browser.

A simple wrapper around `kubectl proxy` + `open http://localhost:8001/ui`.

    $ kube-dash
    <browser should open>
    ctrl-C to exit


BASH / ZSH completion
---------------------

Completion helpers are available for both BASH and ZSH in the `./completions` directory.
These are installed automatically when installing via homebrew.

Developing
==========

- `make lint` to run linters.
- `make test` to run tests.

Submitting changes
------------------

1. Make your branch: `git checkout -b feature-name`
2. Make your edits.
3. Commit to branch, send PR
4. Update `CHANGELOG.md`. Describe your changes in the `[Unreleased]` section.
5. Update `README.md` (if applicable)
6. Merge to master after code-review process.

Updating Homebrew Formula
-------------------------

1. In `CHANGELOG.md` modify `[Unreleased]` to new version, eg: `[0.0.7]` and
   include today's date. Create a new, empty `[Unreleased]` section.
2. Commit changelog update to master and push.
2. Create new tag, eg: `git tag v0.0.7`
3. Push tag to github: `git push --tags`
4. Get the sha256 checksum from the tag tarball: `curl -L https://github.com/joemiller/kubits/archive/v0.0.7.tar.gz | sha256sum`
5. Edit `Formula/kubits.rb`, update `url` and `sha256`
6. Commit updated `Formula/kubits.rb` to master.
7. `git push origin master`

After merge to master you can test your update is available by running the
normal upgrade procedure: `brew update && brew upgrade joemiller/kubits/kubits`

TODO
----

- [ ] include helpers for adding cluster+namespace to bash and zsh prompts
- [x] add circle-ci? add shellcheck for linting
- [ ] bats tests
- [x] make public repo? If so, then we should switch the homebrew formula to use
      a url to the github release tarball as is common practice for most public
      brews. Also the instructions for adding the tap can be shortened to remove the URL.
