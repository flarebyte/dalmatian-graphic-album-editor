#!/usr/bin/env zsh

hash=$(md5 -q docs/main.js)
hashcss=$(md5 -q docs/styles.css)

mv docs/main.js docs/main-$hash.js
sed -i '' "s/main.js/main-$hash.js/" docs/index.html
	
mv docs/styles.css docs/styles-$hashcss.css
sed -i '' "s/styles.css/styles-$hashcss.css/" docs/index.html