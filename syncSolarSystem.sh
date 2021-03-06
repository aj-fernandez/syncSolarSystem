#!/bin/bash

# @author: ajfernandez
# @last_edit: 25/08/19
# @Sync myDocs/ & myRepos/ & myLabs/ & myRepos folders among network nodes.
# @update: added the possibility to select a particular node to sync.

root="site"
nodeName=(
	"jupiter"
	"venus"
#	"saturn" ec2 end subscription
)

totalNodes=${#nodeName[@]}

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
	printf "Usage: ./syncSolarSystem -argument\n\n\tArguments:\n\t\t-jupiter - sync Jupiter node.\n\t\t-venus   - sync Venus node.\n\t\t-all     - sync all nodes.\n"
	elif [ "$1" = "-jupiter" ]; then
		printf '\nSyncing node: jupiter.%s\n\n' "${root}"
		#show each synchronized file:
		#rsync -P -rae ssh /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs /home/ajfernandez/myWorks ajfernandez@jupiter.$root:~/
		rsync --stats -rae ssh /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs /home/ajfernandez/myWorks ajfernandez@jupiter.$root:~/
	elif [ "$1" = "-venus" ]; then
		printf '\nSyncing node: venus.%s\n\n' "${root}"
		#show each synchronized file:
		#rsync -P -rae "ssh -p 2022" /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs /home/ajfernandez/myWorks ajfernandez@venus.$root:~/
		rsync --stats -rae "ssh -p 2022" /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs /home/ajfernandez/myWorks ajfernandez@venus.$root:~/
	elif [ "$1" = "-all" ]; then
		for (( i=0 ; i < totalNodes; i++ )); do
			if [[ "${nodeName[i]}" == 'venus' ]]; then
				printf '\nSyncing node: %s.%s\n\n' "${nodeName[i]}" "${root}" 
				rsync --stats -rae "ssh -p 2022" /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs /home/ajfernandez/myWorks ajfernandez@"${nodeName[i]}".$root:~/
			else
				printf '\nSyncing node: %s.%s\n' "${nodeName[i]}" "${root}" 
				rsync --stats -rae ssh /home/ajfernandez/myDocs /home/ajfernandez/myRepos /home/ajfernandez/myLabs /home/ajfernandez/myWorks ajfernandez@"${nodeName[i]}".$root:~/
			fi
		done
fi
