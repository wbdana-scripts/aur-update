#!/usr/bin/env bash

set_update_or_reinstall ()
{
	# If currently-installed version is the same as the new version,
	# offer to reinstall; otherwise, offer to update
	# Set verb variables accordingly
	printf "${LIGHTCYAN}New Version Number:${NC}     ${LIGHTGREEN}${new_version}${NC}\n"
	if [[ "$current_version" =~ "$new_version" ]]; then
		option="REINSTALL"
		opt_gerund="Reinstalling"
		printf "${LIGHTCYAN}Current Version Number:${NC}${LIGHTGREEN}${current_version}${NC}\n"
	else
		option="UPDATE"
		opt_gerund="Updating"
		printf "${LIGHTCYAN}Current Version Number:${NC} ${YELLOW}${current_version}${NC}\n"
	fi
}
