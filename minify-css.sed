# Script to minify CSS for maximum efficiency

y/\t/ /

s/ *$//
s/^ *//
s/  */ /g

s/: */:/
s/ *;/;/

/{$/ {
	s/ *{$/{/
	s/, */,/g
	s/^@media */@media/
}
