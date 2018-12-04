# AUR-Update

![AUR-Update Demo](https://i.imgur.com/pDaYecW.gif)

## About

This is a simple script to update AUR packages. It assumes that all of your AUR packages are in one directory and have been cloned from the AUR using ```git clone```.

## Installation

1. Clone the repo.
2. Make the installer and script executable: `chmod +x ./install.sh aur-update`
3. Run the installer: `./install.sh`

This will install AUR-Update to `~/.aur-update`, and add that directory to your path in your specified shell configuration file (e.g., `~/.bash_profile` or `~/.zshrc`). Afterwards, restart your current shell or terminal session to be able to run `aur-update` from any directory.

## Usage

After installation, run `aur-update` and follow the prompts on screen in order to loop through your AUR packages and update them. Expanded functionality includes:

```
aur-update -S [package-name]    Install package-name
aur-update -R [package-name]    Uninstall package-name
aur-update -o [package-name]    Update only package-name
aur-update -b                   Update all packages, bypassing optional rebuilds
aur-update -s                   Update aur-pkglist with latest packages in aurpath directory
aur-update -h                   Print help
```

## Comments, Questions, Issues

Please open an issue if you have any concerns about this script.