#!/usr/bin/env bash

get_new_ver ()
{
	# Get pkgver from PKGBUILD, excluding all but the first match
	new_version=$(cat PKGBUILD | grep -m 1 "pkgver=")
	# Strip "pkgver=" from version info
	new_version_len=${#new_version}
	new_version=$(for i in $new_version; do echo ${i:7:$new_version_len}; done)
	new_version_len=${#new_version}
}
