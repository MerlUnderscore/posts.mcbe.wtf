#!/usr/bin/env sh

# The main script that generates the webpage

cd "$(dirname "$0")"

# Incase there are any new users found, this avoids I need to keep manually pulling on my pi.
#git pull

# Get all the forum post counts.
:>counts
while IFS= read -r USER; do
	2>/dev/null curl "https://www.speedrun.com/user/$USER/info" | sed -nf parse.sed |
		xargs -I % echo % $USER >>counts
done <users

# Sort them and get the ranking numbers, taking ties into account.
sort -nr counts | awk -f rank.awk >posts

# Create the index file.
sed '
# Perform HTML minification
s/^[[:space:]]*//

# Update the data
s/<!-- LAST UPDATED -->/'"$(date "+%d %B %Y, %T UTC")"'/
/<!-- POST DATA -->/ {
	r posts
	d
}
' template.html | tr -d '\n' >index.html

# Perform CSS minification
sed -f minify-css.sed template.css | tr -d '\n' >style.css
