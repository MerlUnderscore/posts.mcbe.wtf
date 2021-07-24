# Script to get the players ranks and posts per day

{	if ((page == "total" && $1 == prev) || (page == "ppd" && $2 == prev))
		pos = prev_nr
	else
		pos = NR

	print "<tr><td>"pos"</td><td>"$3"</td><td>"$1"</td><td>"$2"</td></tr>"

	prev = (page == "total") ? $1 : $2
	prev_nr = pos
}
