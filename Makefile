OUTPUT_PATH=$(shell pwd)/build/.less-git-log

install: link-scripts set-lesskey
.PHONY: install

set-lesskey: clean-lesskey
	mkdir build

	lesskey -o $(OUTPUT_PATH) -- ./.lesskey-git-log

	git config --global pager.log "less --lesskey-file=$(OUTPUT_PATH) --chop-long-lines --ignore-case --LONG-PROMPT --LINE-NUMBERS --RAW-CONTROL-CHARS --status-column --tilde"
.PHONY: set-lesskey

clean-lesskey:
	rm -rf ./build

	git config --global --unset pager.log || :
.PHONY: clean

link-scripts: clean-scripts
	ln -s $(shell pwd)/git-log-tools /usr/local/bin/git-log-tools
	chmod -h 755 /usr/local/bin/git-log-tools

	ln -s $(shell pwd)/less-git-tools /usr/local/bin/less-git-tools
	chmod -h 755 /usr/local/bin/less-git-tools
.PHONY: link-scripts

clean-scripts:
	rm /usr/local/bin/git-log-tools || :
	rm /usr/local/bin/less-git-tools || :
.PHONY: clean-scripts

clean: clean-scripts clean-lesskey
.PHONY: clean

uninstall: clean
.PHONY: uninstall