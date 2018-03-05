kubits Change Log
=================

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)

[Unreleased] - ???
--------------------

### Added:
### Changed:
### Fixed:

[0.1.0] - 2018-03-05
--------------------

### Added:

- Added CircleCI (thanks @netflash)
- Added RPM and DEB package builds with hosting on packagecloud.io

### Changed:

- `kube-tail` rewritten using the new [kubectl plguin](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/) API.
  This was primarily undertaken in order to better support interaction with multiple clusters
  using  the `--context` flag. Other global flags are also supported (but untested) such as
  `--server`, `--kubeconfig`, `--user`, etc. Thanks to @craychee for requesting this.
- Bumped minor version to `0.1.0` due to `kube-tail` rewrite to use kubectl-plugins interface.
  It should be backwards-compatible for the most common (known) use cases with additional
  features.

### Fixed:

[0.0.10] - 2018-02-21
---------------------

### Added:
### Changed:
### Fixed:

- Fixed bug bash completion for `kube-ns` which would reset the namespace. Thanks
  @winmillwill

[0.0.9] - 2017-03-09
--------------------

### Added:

- New `kube-dash` micro-util added. Run it to open the kubernetes-dashboard
- of the currently configured cluster in your browser. Uses `kubectl proxy`.

### Changed:
### Fixed:

[0.0.8] - 2017-02-05
-------------------------

### Added:
### Changed:

- BREAKING CHANGE: the interface to `kube-tail` has changed to be more like
  kubectl. Previously `kube-tail app=hermes production` is now
  `kube-tail -l app=hermes --namespace=production`.

### Fixed:

[0.0.7] - 2016-10-18
--------------------

### Added:
- added new `kube-tail` command
- added this `CHANGELOG.md`.
- added a `Makefile` with initial task `readme-toc` for updating the TOC
  in the `README.md` file. Run `make readme-toc` after editing the README
  and before committing changes to git.

### Changed:

- Updated homebrew tap formula to use standard github tarball releases

### Fixed:
