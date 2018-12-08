#!/usr/bin/env bash

prompt_update_or_reinstall ()
{
	# Offer to reinstall or update package
	# 'Y' or 'y' will accept, any other keypress will reject

	# First conditional specifies color of prompt text output
	if [[ $option == "UPDATE" ]]; then
		read -p "$(printf "${LIGHTGREEN}//=> ${NC}${WHITE}Would you like to${NC} ${LIGHTGREEN}${option}${NC} ${LIGHTRED}${pkg_name}${NC}${WHITE}?${NC} [Y/n] ")" -r
	else
		read -p "$(printf "${LIGHTGREEN}//=> ${NC}${WHITE}Would you like to${NC} ${LIGHTCYAN}${option}${NC} ${LIGHTRED}${pkg_name}${NC}${WHITE}?${NC} [Y/n] ")" -r
	fi
	# Second conditional triggers update/reinstall, or prints negative output
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		printf "${LIGHTGREEN}${opt_gerund} ${pkg_name}!${NC}\n"
		makepkg -sirc
	else
		# Convert opt_gerund to lower case
		opt_gerund=$(echo $opt_gerund | tr '[:upper:]' '[:lower:]')
		printf "${LIGHTRED}NOT ${opt_gerund} ${pkg_name}!${NC}\n\n"
	fi
}
