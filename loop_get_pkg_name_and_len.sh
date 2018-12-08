#!/usr/bin/env bash

loop_get_pkg_name_and_len ()
{
	# Get current directory string length
	dir_name_len=${#d}
	# Remove './' from start of current directory
	pkg_name=$(for i in $d; do echo ${i:2:$dir_name_len}; done)
	# Get length of package name plus trailing '/'
	pkg_name_len=${#pkg_name}
	# Remove trailing '/'
	pkg_name=$(for i in $pkg_name; do echo ${i:0:$pkg_name_len - 1}; done)
	# Reset pkg_name_len to length of package name string
	pkg_name_len=${#pkg_name}
}
