# AUR-Update

![AUR-Update Demo](https://i.imgur.com/pDaYecW.gif)

## About

This is a simple script to update AUR packages. It assumes that all of your AUR packages are in one directory and have been cloned from the AUR using ```git clone```.

## Installation

#### New Installation Instructions

As of 2018.09.15, AUR-Update now features an installer. You can still use the old instructions below, but these instructions will allow you to run `aur-update` from anywhere.

1. Clone the repo.
2. Make the installer and script executable: `chmod +x ./install.sh aur-update`
3. Run the installer: `./install.sh`

This will install AUR-Update to `~/.aur-update`, and add that directory to your path in your specified shell configuration file (e.g., `~/.bash_profile` or `~/.zshrc`). Afterwards, restart your current shell or terminal session to be able to run `aur-update` from any directory.

---

#### Old Installation Instructions:

Clone the repo, or just copy `aur.sh` into the directory containing all of your AUR package directories.

Cloning the repository containing your AUR repos will allow you to update AUR Update itself with a simple `git pull`.

Make `aur.sh` executable: `chmod +x aur.sh`

## Usage

#### New Usage Instructions
Run `aur-update` and follow the prompts on screen.

---
#### Old Usage Instructions
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