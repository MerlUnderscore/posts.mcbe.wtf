#!/usr/bin/env sh

# The main script that generates the webpage.

cd "$(dirname "$0")"

# Incase there are any new users found, this avoids I need to keep manually pulling on my pi.
git pull

# Get all the forum post counts.
:>counts
while IFS= read -r USER; do
	2>/dev/null curl "https://www.speedrun.com/user/$USER/info" | sed -nf parse.sed |
		xargs -I % echo % $USER >>counts
done <users

# Sort them and get the ranking numbers, taking ties into account.
sort -nr counts | awk -f rank.awk >posts

# Create and minify the index and style files.
sed -f create-index.sed template.html | tr -d '\n' >index.html
sed -f minify-css.sed template.css | tr -d '\n' >style.css
