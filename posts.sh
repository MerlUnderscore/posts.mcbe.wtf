#!/usr/bin/env sh

# The main script that generates the webpage.

# On my system I have multiple sed(1) implementations installed
SED="/usr/bin/sed"

cd "${0%/*}"

# Incase there are any new users found, this avoids I need to keep manually pulling on my pi.
git pull

# Get all the forum post counts.
:>counts
while IFS= read -r USER; do
	2>/dev/null curl "https://www.speedrun.com/user/$USER/info" | sed -nf parse.sed |
		xargs -I % echo % $USER >>counts
done <users

# Sort them and get the ranking numbers, taking ties into account.
sort -nr counts | awk -v page=total -f rank.awk >total_posts
sort -nrk2 counts | awk -v page=ppd -f rank.awk >posts_per_day

# Create and minify the index and style files.
echo 'total posts' | $SED -f create-html.sed - template.html | tr -d '\n' >index.html
echo 'posts per day' | $SED -f create-html.sed - template.html | tr -d '\n' >ppd.html
$SED -f minify-css.sed template.css | tr -d '\n' >style.css
