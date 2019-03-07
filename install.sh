#!/usr/bin/env bash

install_aur_update ()
{
	echo "Adding specified aur path to AUR-Update script..."
	sed -i "2i aurpath=${aurpath}" ./aur-update
	echo "Making ~/.aur-update if not exists..."
	mkdir -p $HOME/.aur-update
	echo "Copying AUR-Update script to ~/.aur-update..."
	cp ./aur-update $HOME/.aur-update
	echo "Adding ~./aur-update to PATH..."
	sed -i "1i # AUR-Update to \$PATH" "$shell_configuration_file"
	sed -i "2i export PATH=\$HOME/.aur-update:\$PATH" "$shell_configuration_file"
	echo "Creating ~/.aur-update/cache if not exists..."
	mkdir -p $cachepath
	echo "Please restart your current shell or terminal session to enable aur-update"
}

LIGHTRED='\033[1;31m'
NC='\033[0m'

aurpath=$HOME/.aur-update
cachepath=$aurpath/cache

read -p "$(printf "${LIGHTRED}//=> Please enter the EXACT path to your preferred shell configuration file${NC}\ne.g., ${LIGHTRED}/home/wbdana/.bash_profile${NC} or ${LIGHTRED}/home/wbdana/.zshrc${NC} ")" shell_configuration_file

read -p "$(printf "//=> You entered: \n ${LIGHTRED}${shell_configuration_file}${NC}\nIs this correct? [Y/n] ")" -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Installing..."
	install_aur_update
else
	echo "Incorrect path to shell configuration file specified; aborting. Please try again!"
fi

echo "AUR-Update installation complete."
exit 0
