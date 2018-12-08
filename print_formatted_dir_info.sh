#!/usr/bin/env bash

print_formatted_dir_info ()
{
	# Print formatted directory info
	printf "${LIGHTCYAN}${MED_SEPARATOR}${NC}\n"		
	printf "${WHITE}//=>${NC} ${LIGHTRED}${pkg_name}${NC} ${WHITE}<=//${NC}\n"
	printf "${LIGHTCYAN}${MED_SEPARATOR}${NC}\n"
	printf "${YELLOW}pulling from git repository...${NC}\n"
}
