.PHONY: html js

SRC = src
BUILD = docs
HTML = frontend/html

build-directory:
	mkdir -p $(BUILD)

html:
	cp $(HTML)/index.html $(BUILD)/index.html

js:
	cd frontend; elm make $(SRC)/Main.elm --output=../$(BUILD)/main.js

build: build-directory html js

start:
	cd docs;python -m SimpleHTTPServer 7000