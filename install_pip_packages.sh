#!/usr/bin/env fish
# source it from fish

echo TODO - install pip
# get get_pip.py
#curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

for i in (cat pip-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test "(string length $i)" != "0"
		echo $i
		pip install --upgrade (string trim $i)
	end

end


