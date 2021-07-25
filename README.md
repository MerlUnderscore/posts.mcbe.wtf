The speedrun.com Forum Post Leaderboard
=======================================

This site is a leaderboard that ranks users on [https://www.speedrun.com](speedrun.com) with 500+
forum posts. The site supports ranking by either total posts or posts per day (total posts / account
age) and is powered by a custom static site generator.

The static site generator makes use of `awk(1)`, `curl(1)`, `GNU sed(1)` to webscrape a users info
page, get their account age and total forum posts, and create the webpages. Most of the process is
powered by `sed` though.

The site can be found at https://posts.mcbe.wtf
