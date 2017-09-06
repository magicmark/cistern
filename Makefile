all: run

venv: Makefile requirements.txt
	rm -rf venv
	virtualenv venv --python=python3
	venv/bin/pip install -U pip
	venv/bin/pip install -r requirements.txt
	venv/bin/pre-commit install -f --install-hooks

.PHONY: run
run: export ANSIBLE_NOCOWS = 1
run: venv
	cd ansible; ../venv/bin/ansible-playbook main.yml
