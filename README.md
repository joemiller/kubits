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
  * [BASH / ZSH completion](#bash--zsh-completion)
- [Developing](#developing)
  * [TODO](#todo)

<!-- tocstop -->

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

### kube-tail

Tail the logs from multiple pods and containers in a single command.

Each container's output is prefixed with the pod and container the originated
the log line.

Output is colored for improved readability.

Loosely inspired by the Heroku toolbelt's log tail function.

`kube-tail` accepts two arguments:

1. Label selector. This is passed directly to the `-l | --selector` option of
   `kubectl`
2. Namespace. The namespace to query for pods. Defaults to `default` namespace

In this example, there is a single pod with two containers, nginx and myapp:

    $ kubectl get pods -l app=myapp --namespace=production
    NAME                                    READY     STATUS    RESTARTS   AGE
    myapp-11345623-gj2mr                    2/2       Running   0          2d

    $ kube-tail app=myapp production
    |myapp-11345623-gj2mr::nginx | 10.240.0.9 - - [18/Oct/2016:17:56:15 +0000] "GET /api/5bb0c1a8-0ad9-bcee-d3d3-f541bd3e7559/ HTTP/1.1" 200 3918 "-"
    |myapp-11345623-gj2mr::myapp | time="2016-10-18T17:36:29Z" level=info msg="New connection" clientIP=127.0.0.1:37768 conID=0dff04c5-4fa9-436c-8c08-f58d2b4e1e24

BASH / ZSH completion
---------------------

Completion helpers are available for both BASH and ZSH in the `./completions` directory.
These are installed automatically when installing via homebrew.

Developing
==========

Making changes
--------------

1. Make your branch: `git checkout -b feature-name`
2. Make your edits.
3. Commit to branch, send PR
4. Merge to master after code-review process.
5. Create

Updating homebrew Formula
-------------------------

This process assumes

1. Make your branch: `git checkout -b feature-name`
2. Make your edits.
3. Update `CHANGELOG.md`
4. Update `README.md` (if applicable)
5. Commit updates to branch.
6. Create new tag: `git tag v0.0.4`
7. Push your branch: `git push origin feature-name`
8. Push your tag: `git push --tags`
9. Open a pull request, get code review, merge to master

After merge to master you can test your update is available by running the
normal upgrade procedure: `brew update && brew upgrade joemiller/kubits/kubits`

TODO
----

- [ ] include helpers for adding cluster+namespace to bash and zsh prompts
- [ ] add circle-ci? add shellcheck for linting?
- [x] make public repo? If so, then we should switch the homebrew formula to use
      a url to the github release tarball as is common practice for most public
      brews. Also the instructions for adding the tap can be shortened to remove the URL.
