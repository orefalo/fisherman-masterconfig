#!/usr/bin/env fish
# source it from fish

command npm i -g pnpm
pnpm setup

for i in (cat configs/npm/npm-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		cprintf "<fg:yellow>!! Skipping %s</fg>" $i
	else if test -n "$i"
		cprintf "Installing <fg:cyan>%s...</fg>" $i
		pnpm i -g (string trim $i)
	end

end
