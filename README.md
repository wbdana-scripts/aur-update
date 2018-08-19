# AUR-Update

![AUR-Update Demo](https://i.imgur.com/pDaYecW.gif)

## About

This is a simple script to update AUR packages. It assumes that all of your AUR packages are in one directory and have been cloned from the AUR using ```git clone```.

## Installation

Clone the repo, or just copy `aur.sh` into the directory containing all of your AUR package directories.

Cloning the repository containing your AUR repos will allow you to update AUR Update itself with a simple `git pull`.

Make `aur.sh` executable: `chmod +x aur.sh`

## Usage

You can run AUR Update with `./aur.sh`. AUR Update will iterate over every directory in the directory containing `aur.sh`, and at its most basic, run the following commands:

```
git pull
cat PKGBUILD
```

It will then prompt you if you would like to update (or reinstall) the current AUR package. If you press `Y` or `y` and then press enter, it will run:

```makepkg -sirc```

...and then move on to the next AUR package. The rest of the script basically pulls the new package version from the `PKGBUILD`, as well as the currently-installed version from `pacman -Qe | grep $PKG_NAME` for easy comparison of versions, as well as doing a fair bit of text formatting.

## Comments, Questions, Issues

Please open an issue if you have any concerns about this script.