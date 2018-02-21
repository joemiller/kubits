kubits Change Log
=================

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)


[Unreleased] - ???
---------------------

### Added:
### Changed:
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
