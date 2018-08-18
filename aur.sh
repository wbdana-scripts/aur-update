LIGHTPURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
LIGHTCYAN='\033[1;36m'
LIGHTBLUE='\033[1;34m'
ORANGE='\033[0;33m'
DARKGRAY='\033[1;30m'
CYAN='\033[0;36m'

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
NC='\033[0m'

printf "${LIGHT}"

for d in ./*/;
	do
	cd "$d"
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

		printf "${LIGHTCYAN}${PKG_NAME}${NC}\n\n"
		printf "${CYAN}Pulling from git repository...${NC}\n"
		# Store results of git pull for formatted output
		PULL=$(git pull)
		if [ "$PULL" == "Already up to date." ]; then
			printf "${GREEN}${PULL}${NC}"
		elif [ "$PULL" == *"fatal" ]; then
			printf "${RED}${PULL}${NC}"
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

		# If currently-installed version is the same as the new version,
		# offer to rebuild; otherwise, offer to update
		# Set verb variables accordingly
		printf "New Version Number:     ${GREEN}${NEW_VERSION}${NC}\n"
		if [[ "$CURRENT_VERSION" =~ "$NEW_VERSION" ]]; then
			OPTION="rebuild"
			OPT_GERUND="Rebuilding"
			printf "Current Version Number:${GREEN}${CURRENT_VERSION}${NC}\n"
		else
			OPTION="Update"
			OPT_GERUND="Updating"
			printf "Current Version Number:${YELLOW}${CURRENT_VERSION}${NC}\n"
		fi
		echo # New line

		# Grab contents of PKGBUILD
		# and print for review
		PKG=$(cat PKGBUILD)
		printf "${NC}${PKG}${NC}"
		echo && echo # New lines

		# Offer to rebuild or update package
		# 'Y' or 'y' will accept, any other keypress will reject
	
		# '\033[1;33m'
		# '\e[31mFoobar\e[0m:
		# read -p "$(echo -e $BOLD$YELLOW"foo bar "$RESET)" INPUT_VARIABLE
		read -p "$(printf "${LIGHTGREEN}Would you like to${NC} ${RED}${OPTION}${NC} ${LIGHTCYAN}${PKG_NAME}${NC}${LIGHTGREEN}?${NC} ")" -r
		# read -p "Would you like to ${OPTION} ${PKG_NAME}? " -n 1 -r
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo
			printf "${GREEN}${OPT_GERUND} ${PKG_NAME}!${NC}"
			makepkg -sirc
		else
			# Convert OPT_GERUND to lower case
			OPT_GERUND=$(echo $OPT_GERUND | tr '[:upper:]' '[:lower:]')
			printf "${RED}Not ${OPT_GERUND} ${PKG_NAME}!${NC}"
			echo && echo
		fi

		# Go back to top level directory for next iteration
		cd ..;
done
