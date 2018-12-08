#!/usr/bin/env bash

add_pkg_name_to_pkglist ()
{
	pkg_list=$(echo $pkg_list $pkg_name)
}
