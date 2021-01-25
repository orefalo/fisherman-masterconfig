# source it from fish

for i in (cat fish_plugins)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test "(string length $i)" != "0"
		echo $i
		fisher install (string trim $i)
	end

end

nvm install lts
nvm use lts

