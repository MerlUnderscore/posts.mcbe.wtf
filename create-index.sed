# Creates the index.html file and performs a little bit of minification

# Perform HTML minification
s/^[[:space:]]*//

# Update the data
/<!-- LAST UPDATED -->/ {
	h
	s/\(.*\)<!--.*/\1/p
	e date "+%d %B %Y, %T UTC"
	g
	s/.*-->\(.*\)/\1/
}

/<!-- POST DATA -->/ {
	r posts
	d
}
