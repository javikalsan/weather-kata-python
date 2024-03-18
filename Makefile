.PHONY: default
default:
	@printf "$$HELP"

.PHONY: kata-deps
kata-deps:
	test -e .venv || python -m venv .venv
	.venv/bin/pip install -r requirements.txt

.PHONY: kata-watch-tests
kata-watch-tests:
	.venv/bin/watchmedo shell-command \
		--patterns="*.py" \
		--recursive \
		--command ".venv/bin/python -m unittest tests/test_weather.py"

.PHONY: kata-tests
kata-tests:
	.venv/bin/python -m unittest tests/test_weather.py

.PHONY: kata-coverage
kata-coverage:
	.venv/bin/coverage run --source=weather -m unittest
	.venv/bin/coverage report
	.venv/bin/coverage html
	@printf "To visualize the lines open the report at htmlcov/index.html\n"

define HELP
    - make kata-deps\t\tInstall kata dependencies
    - make kata-tests\t\tExecute tests
    - make kata-watch-tests\tExecute tests when changes
    - make kata-coverage\tGenerate test coverage report

Please execute "make <command>". Example: make kata-tests

endef

export HELP

