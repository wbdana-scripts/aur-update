#!/usr/bin/env bash

determine_longest_package_name_len ()
{
	longest_pkg_name_len=0
	for d in ./*/; do
		loop_get_pkg_name_and_len
		if [ "$pkg_name_len" -gt "$longest_pkg_name_len" ]; then
			longest_pkg_name_len="$pkg_name_len"
		fi
	done
}
