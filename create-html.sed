# Creates the index.html file and performs a little bit of minification

# The first line of input is either the string "total posts" or "posts per day" and we use this
# information to tell which of the two pages we need to generate, so we save it in the hold space
# for later.
1 {
	h
	d
}

# Perform HTML minification.
s/^[[:space:]]*//

# Read the stored metadata from the hold space into the pattern space to link to the table that is
# not the one currently selected.
/class="links"/ {
	x
	/total posts/ {
		x
		s|Rank by Posts per Day|<a href="ppd.html">&</a>|
	}
	/posts per day/ {
		x
		s|Rank by Total Posts|<a href="index.html">&</a>|
	}
}

# Update the modification date
s/\(.*\)<!-- LAST UPDATED -->\(.*\)/date "+\1%d %B %Y, %T UTC\2"/e

# Read the stored metadata from the hold space into the pattern space and create the appropriate
# table.
/<!-- POST DATA -->/ {
	g
	/total posts/r total_posts
	/posts per day/r posts_per_day
	d
}
