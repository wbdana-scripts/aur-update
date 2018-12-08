#!/usr/bin/env bash


git_pull ()
{
	# Store results of git pull for formatted output
	pull=$(git pull)
	if [ "$pull" == "Already up to date." ]; then
		printf "${LIGHTGREEN}${pull}${NC}"
	elif [ "$pull" == *"fatal" ]; then
		printf "${LIGHTRED}${pull}${NC}"
	else
		printf "${LIGHTCYAN}${pull}${NC}"
	fi
}
