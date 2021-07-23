# Script to parse the players profile for the required data

# These two lines aren't neccesary but they help avoid some false matches hopefully
s/^[[:space:]]*//
0,/<div>Info<\/div>/d

# Save the signup date in the hold space
/Signed up:/ {
	s/.*Signed up:.*datetime="\([^"]*\).*/\1/
	h
}

# Append the saved sign up to the pattern space and print it
/Posts:/ {
	s/.*Posts:[^0-9]*\([0-9]*\).*/\1/
	G
	y/\n/ /
	p
	q
}
