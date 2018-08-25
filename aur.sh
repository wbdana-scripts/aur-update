#!/usr/bin/env bash
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'
MINI_SEPARATOR="=================="
END_SEPARATOR="============================="
LOGO="+=====================================================================================+
|    _____   ____ _____________           ____ ___            .___       __           |
|   /  _  \ |    |   \______   \         |    |   \______   __| _/____ _/  |_  ____   |
|  /  /_\  \|    |   /|       _/  ______ |    |   /\____ \ / __ |\__  \\   __ \/ __ \  |
| /    |    \    |  / |    |   \ /_____/ |    |  / |  |_> > /_/ | / __ \|  | \  ___/  |
| \____|__  /______/  |____|_  /         |______/  |   __/\____ |(____  /__|  \___  > |
|         \/                 \/                    |__|        \/     \/          \/  |
+=====================================================================================+"

# Print logo, initialization text
printf "${LIGHTCYAN}${LOGO}${NC}\n\n"
printf "${WHITE}By: wbdana\n"
printf "    https://github.com/wbdana/aur-update\n\n"
printf "Starting updates...\n${NC}"

# Make package list and old package list files if they do not exist
# Convert package list to old package list
# Remake package list
touch aur-pkglist aur-pkglist.old
mv ./aur-pkglist ./aur-pkglist.old
touch aur-pkglist

for d in ./*/; do
	# Get current directory string length
	DIR_NAME_LEN=${#d}
	# Remove './' from start of current directory
	PKG_NAME=$(for i in $d; do echo ${i:2:$DIR_NAME_LEN}; done)
	# Get length of package name plus trailing '/'
	PKG_NAME_LEN=${#PKG_NAME}
	# Remove trailing '/'
	PKG_NAME=$(for i in $PKG_NAME; do echo ${i:0:$PKG_NAME_LEN - 1}; done)
	# Reset PKG_NAME_LEN to length of package name string
	PKG_NAME_LEN=${#PKG_NAME}

	# Add PKG_NAME to package list
	echo $PKG_NAME >> aur-pkglist

	# cd into AUR package directory
	cd "$d"

	# Make a separator of length equal to
	# "//=> ${PKG_NAME} <=//"
	SEPARATOR_SIZE=`expr $PKG_NAME_LEN + 10`
	MED_SEPARATOR=""
	for i in $(seq 1 $SEPARATOR_SIZE); do
		MED_SEPARATOR+="="
	done

	# Print formatted directory info
	printf "${LIGHTCYAN}${MED_SEPARATOR}${NC}\n"		
	printf "${WHITE}//=>${NC} ${LIGHTRED}${PKG_NAME}${NC} ${WHITE}<=//${NC}\n"
	printf "${LIGHTCYAN}${MED_SEPARATOR}${NC}\n"
	printf "${YELLOW}Pulling from git repository...${NC}\n"

	# Store results of git pull for formatted output
	PULL=$(git pull)
	if [ "$PULL" == "Already up to date." ]; then
		printf "${LIGHTGREEN}${PULL}${NC}"
	elif [ "$PULL" == *"fatal" ]; then
		printf "${LIGHTRED}${PULL}${NC}"
	else
		printf "${LIGHTCYAN}${PULL}${NC}"
	fi
	echo && echo # New lines

	# Get pkgver from PKGBUILD, excluding all but the first match
	NEW_VERSION=$(cat PKGBUILD | grep -m 1 "pkgver=")
	# Strip "pkgver=" from version info
	NEW_VERSION_LEN=${#NEW_VERSION}
	NEW_VERSION=$(for i in $NEW_VERSION; do echo ${i:7:$NEW_VERSION_LEN}; done)
	NEW_VERSION_LEN=${#NEW_VERSION}

	# Get currently installed package version from pacman
	PACMAN_OUTPUT=$(pacman -Qe | grep $PKG_NAME)
	# Strip package name from version info
	CURRENT_VERSION=${PACMAN_OUTPUT:PKG_NAME_LEN}
	CURRENT_VERSION_LEN=`echo -n $CURRENT_VERSION | wc -m`

	# Remove trailing "-1", etc. from currently installed version info
	if [[ $CURRENT_VERSION =~ .*-.* && "$CURRENT_VERSION_LEN" -ne "$NEW_VERSION_LEN" ]]; then
		DIFF=`expr $NEW_VERSION_LEN - $CURRENT_VERSION_LEN`
		CURRENT_VERSION=${CURRENT_VERSION:0:DIFF}
		CURRENT_VERSION_LEN=`echo -n $CURRENT_VERSION | wc -m`
	fi
	echo && echo
	if [[ $CURRENT_VERSION =~ .*:.* || "$CURRENT_VERSION_LEN" -ne "$NEW_VERSION_LEN" ]]; then
		printf "${LIGHTGREEN}Current: ${CURRENT_VERSION}${NC}\n"
		printf "${LIGHTGREEN}New:        ${NEW_VERSION}${NC}\n\n\n"
	fi

	# If currently-installed version is the same as the new version,
	# offer to reinstall; otherwise, offer to update
	# Set verb variables accordingly
	printf "${LIGHTCYAN}New Version Number:${NC}     ${LIGHTGREEN}${NEW_VERSION}${NC}\n"
	if [[ "$CURRENT_VERSION" =~ "$NEW_VERSION" ]]; then
		OPTION="REINSTALL"
		OPT_GERUND="Reinstalling"
		printf "${LIGHTCYAN}Current Version Number:${NC}${LIGHTGREEN}${CURRENT_VERSION}${NC}\n"
	else
		OPTION="UPDATE"
		OPT_GERUND="Updating"
		printf "${LIGHTCYAN}Current Version Number:${NC} ${YELLOW}${CURRENT_VERSION}${NC}\n"
	fi
	echo # New line


	# Grab contents of PKGBUILD
	# and print for review
	printf "${LIGHTCYAN}${MINI_SEPARATOR}${NC}\n"
	printf "${WHITE}//=> ${NC}${LIGHTCYAN}PKGBUILD${NC}${WHITE} <=//${NC}\n"
	printf "${LIGHTCYAN}${MINI_SEPARATOR}${NC}\n"
	PKG=$(cat PKGBUILD)
	printf "${WHITE}${PKG}${NC}"
	echo && echo # New lines

	# Offer to reinstall or update package
	# 'Y' or 'y' will accept, any other keypress will reject
	if [[ $OPTION == "UPDATE" ]]; then
		read -p "$(printf "${LIGHTGREEN}//=> ${NC}${WHITE}Would you like to${NC} ${LIGHTGREEN}${OPTION}${NC} ${LIGHTRED}${PKG_NAME}${NC}${WHITE}?${NC} [Y/n] ")" -r
	else
		read -p "$(printf "${LIGHTGREEN}//=> ${NC}${WHITE}Would you like to${NC} ${LIGHTCYAN}${OPTION}${NC} ${LIGHTRED}${PKG_NAME}${NC}${WHITE}?${NC} [Y/n] ")" -r
	fi
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		printf "${LIGHTGREEN}${OPT_GERUND} ${PKG_NAME}!${NC}\n"
		makepkg -sirc
	else
		# Convert OPT_GERUND to lower case
		OPT_GERUND=$(echo $OPT_GERUND | tr '[:upper:]' '[:lower:]')
		printf "${LIGHTRED}NOT ${OPT_GERUND} ${PKG_NAME}!${NC}\n\n"
	fi

	# Go back to top level directory for next iteration
	cd ..;
done

printf "${LIGHTCYAN}${END_SEPARATOR}${NC}\n"
printf "${WHITE}//=> ${LIGHTGREEN}AUR Update complete!${NC}${WHITE}<=//${NC}\n"
printf "${LIGHTCYAN}${END_SEPARATOR}${NC}\n"