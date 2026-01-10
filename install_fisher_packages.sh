#!/usr/bin/env fish
# source it from fish

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

for i in (cat configs/fisher/fisher-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		cprintf "<fg:yellow>!! Skipping %s</fg>" $i
	else if test -n "$i"
		cprintf "Installing <fg:cyan>%s...</fg>" $i
		fisher install (string trim $i)
	end

end


