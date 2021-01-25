# source it from fish

for i in (cat fish_plugins)
	echo $i
	fisher install $i
end