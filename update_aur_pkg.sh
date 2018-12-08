#!/usr/bin/env bash

update_aur_pkg ()
{
	make_separator
	print_formatted_dir_info
	git_pull
	echo && echo # New lines
	get_new_ver
	get_current_ver
	set_update_or_reinstall
	echo # New line
	# If $bypass = true && $option="REINSTALL", move to next pkg
	if [[ $option == "REINSTALL" ]] && [[ $bypass == true ]]; then
		printf "${LIGHTRED}${pkg_name}${WHITE} is up to date; skipping.\n"
	else
		print_pkgbuild
		echo && echo # New lines
		prompt_update_or_reinstall
	fi
	cd ..;
}
