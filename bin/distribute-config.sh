#!/bin/bash

for remote in "pcsochor-gpu" "merlin"
do
	echo "------ $remote -------"
	ssh isochor@$remote 'cd ~/scripts_config && git pull'
	echo
	echo
done