#!/usr/bin/env bash

install_new () {
	cd "$pkg_name"
	makepkg -sirc
}
