all: run

venv: Makefile requirements.txt
	rm -rf venv
	virtualenv venv --python=python3
	venv/bin/pip install -r requirements.txt
	venv/bin/pre-commit install -f --install-hooks

.PHONY: run
run:
	cd ansible; ansible-playbook main.yml
