all: run

PYTHON3 := $(shell command -v python3.7 || command -v python3)

venv: Makefile requirements.txt
	rm -rf venv
	$(PYTHON3) tools/get-virtualenv.py venv --python=$(PYTHON3)
	venv/bin/pip install -U pip
	venv/bin/pip install -r requirements.txt
	venv/bin/pre-commit install -f --install-hooks

.PHONY: run
run: export ANSIBLE_NOCOWS = 1
run: venv
	# change to -l nikon to run on personal devbox
	venv/bin/ansible-playbook ansible/main.yml -i hosts -l localhost
