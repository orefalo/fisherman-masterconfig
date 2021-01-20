#!/bin/sh

for i in `fd -t d node_modules .`
do
	echo $i
	rm -rf $i
done

for i in `fd -t d dist .`
do
	echo $i
	rm -rf $i
done

