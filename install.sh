#!/usr/bin/env bash

# DESTINATION="/bin/aur-update"
# mkdir -p ${DESTINATION}

install_aur_update ()
{
	# Add specified aur path to AUR-Update script
	sed -i "2i aurpath=${aurpath}" ./aur-update
	# Copy AUR-Update script to /usr/local/bin/
	cp ./aur-update /usr/local/bin/aur-update
}

LIGHTRED='\033[1;31m'
NC='\033[0m'
# Prompt user for path to AUR package directory
read -p "$(printf "${LIGHTRED}//=> Please enter the path to your AUR package directory${NC}\ne.g., ~/aur-packages ")" aurpath

read -p "$(printf "//=> You entered: \n ${LIGHTRED}${aurpath}${NC}\nIs this correct? [Y/n] ")" -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Installing..."
	install_aur_update
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