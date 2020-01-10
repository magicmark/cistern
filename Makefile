all: run

PYTHON3 := $(shell command -v python3.7 || command -v python3)

.PHONY: venv
venv: Makefile requirements.txt
	# https://github.com/python-poetry/poetry/issues/536#issuecomment-498308796
	python3 $(HOME)/.poetry/bin/poetry install

.PHONY: galaxy
galaxy:
	~/.poetry/bin/poetry run ansible-galaxy install geerlingguy.homebrew

.PHONY: run
run: export ANSIBLE_NOCOWS = 1
run: venv
	# change to -l nikon to run on personal devbox
	$(HOME)/.poetry/bin/poetry run ansible-playbook ansible/main.yml -i hosts -l localhost --ask-become-pass
