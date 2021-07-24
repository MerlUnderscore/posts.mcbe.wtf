# Script to parse the players profile for the required data

# These two lines aren't neccesary but they help avoid some false matches hopefully
s/^[[:space:]]*//
0,/<div>Info<\/div>/d

# Save the signup date in the hold space
/Signed up:/ {
	s/.*Signed up:.*datetime="\([^"]*\).*/\1/
	h
}

/Posts:/ {
	# Get the number of posts and append the signup date to it from the hold space
	s/.*Posts:[^0-9]*\([0-9]*\).*/\1/
	G
	y/\n/ /
	# Calculate the posts per day and output everything in the format
	# <posts> <posts per day>
	s/\([^ ]*\) \(.*\)/printf "\1 "; echo "scale = 2; \1 \/ (($(date "+%s") - $(date -d "\2" "+%s")) \/ 86400)" | bc/
	e
	s/ \./ 0./
	p
	q
}
