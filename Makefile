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

beautify:
	cd frontend; elm-format src/ --yes

mint:
	zsh scripts/mint.sh
	
test:
	cd frontend; elm-test

build: build-directory html js

start:
	cd docs;python -m SimpleHTTPServer 7000