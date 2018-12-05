#!/bin/bash

# @author: ajfernandez
# @last_edit: 2/12/18
# @Sync myDocs/ folder among my network nodes.

root="ajfernandez.me"
nodeName=(
	"jupiter"
	"venus"
	"saturn"
)

totalNodes=${#nodeName[@]}

for (( i = 0; i < totalNodes; i++ )); do
	if [ $nodeName[i] != $nodeName[1] ]; then
		rsync -P -rave ssh /home/ajfernandez/myDocs ajfernandez@"${nodeName[i]}".$root:~/
	elif [ $nodeName[i] == $nodeName[1] ]; then
		rsync -P -rav -e "ssh -p 2022" /home/ajfernandez/myDocs ajfernandez@"${nodeName[i]}".$root:~/
	fi
done
