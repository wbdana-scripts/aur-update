# AUR-Update

![AUR-Update Demo](https://i.imgur.com/pDaYecW.gif)

## About

This is a ~~simple~~ script to update AUR packages. It assumes that all of your AUR packages are in one directory and have been cloned from the AUR using ```git clone```.

I initially started this project as a simple script to loop through my AUR packages and run `git pull` and `makepkg -sirc` on them so I could simply update them. I found the idea of using an AUR helper, like `yay` appealing, but I also wanted to make sure I understood how to handle AUR packages correctly myself. I also wanted to learn a bit more about shell scripting, hence we have AUR-Update.

This project has, in my opinion, grown beyond the point at which it should be a shell script, so I am (slowly) moving functionality over to a Python script at [AHYU](https://www.github.com/wbdana/ahyu). I may still update this script from time to time because I am still using it while I move over to AHYU.

## Installation

1. Clone the repo.
2. Make the installer and script executable: `chmod +x ./install.sh aur-update`
3. Run the installer: `./install.sh`

This will install AUR-Update to `~/.aur-update`, and add that directory to your path in your specified shell configuration file (e.g., `~/.bash_profile` or `~/.zshrc`). Afterwards, restart your current shell or terminal session to be able to run `aur-update` from any directory.

## Usage

After installation, run `aur-update` and follow the prompts on screen in order to loop through your AUR packages and update them. Expanded functionality includes:

```
aur-update -l					List installed packages
aur-update -S [package-name]    Install package-name
aur-update -R [package-name]    Uninstall package-name
aur-update -o [package-name]    Update only package-name
aur-update -b                   Update all packages, bypassing optional rebuilds
aur-update -s                   Update aur-pkglist with latest packages in aurpath directory
aur-update -h                   Print help
```

## Comments, Questions, Issues

Please open an issue if you have any concerns about this script.