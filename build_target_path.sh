#!/usr/bin/env bash

build_target_path ()
{
	first="https://aur.archlinux.org/"
	ext=".git"
	path="$first$pkg_name$ext"
}
