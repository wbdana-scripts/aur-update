#!/usr/bin/env bash

loop_update_packages ()
{
	init_pkg_list
	print_starting_updates
	for d in ./*/; do
		loop_get_pkg_name_and_len
		add_pkg_name_to_pkg_list
		cd "$d"
		update_aur_pkg
	done
	sync_pkg_list
	print_end_message
	exit 0
}
