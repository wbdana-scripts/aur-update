#!/usr/bin/env bash

make_separator ()
{
	# Make a separator of length equal to
	# "//=> ${pkg_name} <=//"
	SEPARATOR_SIZE=`expr $pkg_name_len + 10`
	MED_SEPARATOR=""
	for i in $(seq 1 $SEPARATOR_SIZE); do
		MED_SEPARATOR+="="
	done
}
