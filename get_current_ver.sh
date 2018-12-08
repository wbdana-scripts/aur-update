#!/usr/bin/env bash

get_current_ver ()
{
	# Get currently installed package version from pacman
	pacman_output=$(pacman -Qm | grep $pkg_name)
	# Strip package name from version info
	current_version=${pacman_output:pkg_name_len}
	current_version_len=`echo -n $current_version | wc -m`

	# Remove trailing "-1", etc. from currently installed version info
	if [[ $current_version =~ .*-.* && "$current_version_len" -ne "$new_version_len" ]]; then
		diff=`expr $new_version_len - $current_version_len`
		current_version=${current_version:0:diff}
		current_version_len=`echo -n $current_version | wc -m`
	fi
}
