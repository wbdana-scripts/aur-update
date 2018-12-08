#!/usr/bin/env bash

list_installed ()
{
	printf "${LIGHTRED}Listing installed packages...${NC}\n"
	determine_longest_package_name_len
	max_spaces=`expr $longest_pkg_name_len + 4`
	for d in ./*/; do
		loop_get_pkg_name_and_len
		cd "$d"
		get_new_ver
		get_current_ver
		spaces=""
		spaces_to_add=`expr $max_spaces - $pkg_name_len`
		for i in $(seq 1 $spaces_to_add); do
			spaces+=" "
		done
		printf "${WHITE}${pkg_name}${spaces}${LIGHTCYAN}${current_version}${NC}\n"
		cd ..
	done
	exit 0
}
