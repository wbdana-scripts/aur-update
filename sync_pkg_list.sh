#!/usr/bin/env bash

sync_pkg_list ()
{
	# Make package list and old package list files if they do not exist
	# Convert package list to old package list
	# Remake package list
	touch aur-pkglist aur-pkglist.old
	mv aur-pkglist aur-pkglist.old
	touch aur-pkglist

	# Add package list to new package list file
	echo $pkg_list >> aur-pkglist
}
