#!/bin/sh

for i in `find . -name 'node_modules' -type d -prune`
do
	echo $i
	rm -rf $i
done

for i in `find . -name 'dist' -type d -prune`
do
	echo $i
	rm -rf $i
done
