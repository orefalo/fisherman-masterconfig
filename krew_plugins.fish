# source it from fish

# Install krew pkg mgr
brew install krew

kubectl krew upgrade

for i in (cat krew-packages.txt)

	if test (string sub -l 1 "$i") = "#"
		echo Skipping $i
	else if test "(string length $i)" != "0"
		echo $i
		kubectl krew install (string trim $i)
	end

end


