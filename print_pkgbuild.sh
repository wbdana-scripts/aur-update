#!/usr/bin/env bash

print_pkgbuild ()
{
	# Grab contents of PKGBUILD
	# and print for review
	printf "${LIGHTCYAN}${MINI_SEPARATOR}${NC}\n"
	printf "${WHITE}//=> ${NC}${LIGHTCYAN}PKGBUILD${NC}${WHITE} <=//${NC}\n"
	printf "${LIGHTCYAN}${MINI_SEPARATOR}${NC}\n"
	PKG=$(cat PKGBUILD)
	printf "${WHITE}${PKG}${NC}"
}
