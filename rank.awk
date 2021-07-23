# Script to get the players ranks and posts per day

{	if ($1 == prev)
		pos = prev_nr
	else
		pos = NR

	cmd = "echo \"scale = 2; "$1" / (($(date \"+%s\") - $(date -d \""$2"\" \"+%s\")) / 86400)\" | bc"
	(cmd | getline ppd)
	ppd = sprintf("%.2f", ppd)
	print "<tr><td>"pos"</td><td>"$3"</td><td>"$1"</td><td>"ppd"</td></tr>"
	close(cmd)

	prev = $1
	prev_nr = pos
}
