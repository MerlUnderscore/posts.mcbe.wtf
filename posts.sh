#!/usr/bin/env sh

cd "$(dirname "$0")"

:>counts
while IFS= read -r USER; do
	2>/dev/null curl "https://www.speedrun.com/user/$USER/info" |
		sed -n 's|.*<p><strong>Posts:</strong> \([0-9]*\)</p>.*|\1 '$USER'|p' >>counts
done <users

sort -nr counts | awk '
{
	if ($1 == prev)
		line = prev_nr
	else
		line = NR

	print "<tr><td>"line"</td><td>"$2"</td><td>"$1"</td></tr>"
	prev = $1
	prev_nr = line
}
' >posts

sed "
s/<!-- LAST UPDATED -->/$(date "+%d %B %Y, %T") UTC/
/<!-- POST DATA -->/r posts
" template.html >index.html
