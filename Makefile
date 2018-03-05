SCRIPTS := kube-cluster kube-dash kube-ns kubectl-plugins/tail/tail.sh

lint: ## run all linters
	@bash ./scripts/lint.sh

test: ## run tests
	@bash ./scripts/test.sh $(SCRIPTS)

readme-toc: ## update the Table of Contents in ./README.md (replaces <!-- toc --> tag)
	@docker run --rm -v `pwd`:/src quay.io/getpantheon/markdown-toc -i /src/README.md

packages: ## build rpm, deb packages
	@bash ./scripts/packages.sh

help: ## print list of tasks and descriptions
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

.PHONY:: all help
