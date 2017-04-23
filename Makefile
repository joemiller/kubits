VERSION=0.0.8

help: ## print list of tasks and descriptions
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

readme-toc: ## update the Table of Contents in ./README.md (replaces <!-- toc --> tag)
	docker run --rm -v `pwd`:/src quay.io/getpantheon/markdown-toc -i /src/README.md

rpm: ## build an installable rpm package
	PKG_TYPE=rpm VERSION=$(VERSION) ./package.sh

deb: ## build an installable debian package
	PKG_TYPE=deb VERSION=$(VERSION) ./package.sh

.PHONY:: all help
