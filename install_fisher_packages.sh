#!/usr/bin/env fish
# source it from fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

for i in (cat fisher-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test -n "$i"
		echo $i
		fisher install (string trim $i)
	end

end

nvm install lts

