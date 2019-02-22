#!/bin/bash

# @author: ajfernandez
# @last_edit: 2/12/18
# @Sync myDocs/ & myRepos/ folders among network nodes.

root="ajfernandez.me"
nodeName=(
	"jupiter"
	"venus"
#	"saturn" ec2 end subscription
)

totalNodes=${#nodeName[@]}

for (( i=0 ; i < totalNodes; i++ )); do
	if [[ "${nodeName[i]}" == 'venus' ]]; then
		printf '\nSyncing node: %s.%s\n\n' "${nodeName[i]}" "${root}" 
		rsync -P -rav -e "ssh -p 2022" /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs ajfernandez@"${nodeName[i]}".$root:~/
	else
		printf '\nSyncing node: %s.%s\n' "${nodeName[i]}" "${root}" 
		rsync -P -rave ssh /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs ajfernandez@"${nodeName[i]}".$root:~/
	fi
done
