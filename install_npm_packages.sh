#!/usr/bin/env fish
# source it from fish

npm i -g pnpm
pnpm setup

for i in (cat npm-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test "(string length $i)" != "0"
		echo $i
		pnpm i -g (string trim $i)
	end

end
