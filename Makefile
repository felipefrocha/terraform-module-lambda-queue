.ONESHELL:
SHELL := /bin/bash
RANDOM := $(shell bash -c 'echo $$RANDOM')
BACKEND?=../../smart-backend
ENV?=dev

# cnf ?= .env
# include $(cnf)
# export $(shell sed 's/=.*//' $(cnf))

# Get the latest tag
TAG = $(shell git describe --tags --abbrev=0)
GIT_COMMIT = $(shell git log -1 --format=%h)

FOLDER := $(shell echo $${PWD} | rev | cut -d/ -f1 | rev)
FOLDER_NAME := $(shell printf '%s\n' "${FOLDER}" | awk '{ print toupper($$0) }')

CASE?=case

.PHONY: help

help: ## This help.

	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

install: ## Install all tools needed (unless python)
	@echo Install Terraform docs
	@curl -Lo /tmp/terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$$(uname)-amd64.tar.gz 
	@curl -Lo /tmp/graphviz.tar.gz https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/2.50.0/graphviz-2.50.0.tar.gz
	@tar -xzf /tmp/terraform-docs.tar.gz -C /tmp/
	@tar -xzf /tmp/graphviz.tar.gz -C /tmp/
	@(cd /tmp/graphviz-2.50.0 && ./configure && make && make install && cd -) || exit 1
	@sudo mv /tmp/terraform-docs /usr/local/bin/terraform-docs
	@echo Installed terraform docs
	@echo Install digrams
	@pip install diagrams
	
setup: ## Setup git hooks for documents
	@cat>./.git/hooks/pre-commit<<EOF
	#!/bin/bash
	cd "$$PWD"
	make docs
	git add "./*README.md"
	EOF
	@chmod +x .git/hooks/pre-commit
	@cat>./.git/hooks/post-commit<<EOF
	#!/bin/bash
	cd "$$PWD"
	git add "./*README.md"
	git commit -m "Updating Terraform Modules with terraform-docs"
	EOF
	@chmod +x ./.git/hooks/post-commit

docs: ## Configure docs
	@printf "\n\033[35;1mUpdating the following READMEs with terraform-docs\033[0m\n\n"
	@./.diagram/gen_diagram
	@cat > README.md <<EOF
	$$(echo -e "#  $(FOLDER_NAME)  \n\n")
	
	- Author: [Felipe F. Rocha](https://github.com/felipefrocha)

	$$(echo -e "## Diagram \n---\n<p align="center"><img src=\"./.diagram/diagram.png\" alt=\"drawing\" width=\"50%\"/></p>\n")
	$$(echo )

	$$(terraform-docs md .)
	EOF


example: # Make a example
	@mkdir -p examples/${CASE}
	@touch main.tf variables.tf output.tf