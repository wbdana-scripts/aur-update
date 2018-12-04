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

After installation, run `aur-update` and follow the prompts on screen.

## Comments, Questions, Issues

Please open an issue if you have any concerns about this script.