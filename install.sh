#!/usr/bin/env bash

# DESTINATION="/bin/aur-update"
# mkdir -p ${DESTINATION}

install_aur_update ()
{
	# echo "Add specified aur path to AUR-Update script..."
	# sed -i "2i aurpath=${aurpath}" ./aur-update
	# echo "Making ~/.aur-update if not exists..."
	# mkdir -p $HOME/.aur-update
	# echo "Copying AUR-Update script to ~/.aur-update"
	# cp ./aur-update $HOME/.aur-update
	# echo "Adding ~./aur-update to PATH"
	# sed -i "2i export PATH=$HOME/.aur-update:\$PATH" $shell_configuration_file
	# echo "Sourcing $shell_configuration_file for immediate use"
	# source $shell_configuration_file
}

LIGHTRED='\033[1;31m'
NC='\033[0m'
# Prompt user for path to AUR package directory
read -p "$(printf "${LIGHTRED}//=> Please enter the path to your AUR package directory${NC}\ne.g., ~/aur-packages \n")" aurpath

read -p "$(printf "//=> You entered: \n ${LIGHTRED}${aurpath}${NC}\nIs this correct? [Y/n] ")" -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
	read -p "$(printf "${LIGHTRED}//=> Please enter the path to your shell configuration file${NC}\ne.g., ${LIGHTRED}~/.bash_profile${NC} or ${LIGHTRED} ~/.zshrc${NC} ")" shell_configuration_file

	read -p "$(printf "//=> You entered: \n ${LIGHTRED}${shell_configuration_file}${NC}\nIs this correct? [Y/n] ")" -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Installing..."
		install_aur_update
	fi
else
	echo "Incorrect path to AUR package directory, aborting. Please try again!"
fi





# Append the path to aur.sh
# sed -i "2i AURPATH=${aurpath}" aur-update
# sed -i "2i AURPATH=${aurpath}" ./test.sh
# sed -i "3i echo $aurpath" ./test.sh

echo "AUR-Update installation complete."

exit 0

# __ARCHIVE__