#!/usr/bin/env fish
# source it from fish

# Install krew pkg mgr
brew install krew

kubectl krew upgrade

for i in (cat configs/krew/krew-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		cprintf "<fg:yellow>!! Skipping %s</fg>" $i
	else if test -n "$i"
		cprintf "Installing <fg:cyan>%s...</fg>" $i
		kubectl krew install (string trim $i)
	end

end


