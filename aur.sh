RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

for d in ./*/;
	#do (cd "$d" && cat PKGBUILD);
	do
	cd "$d"
		DIR_NAME_LEN=${#d}
		PKG_NAME=$(for i in $d; do echo ${i:2:$DIR_NAME_LEN}; done)
		PKG_NAME_LEN=${#PKG_NAME}
		PKG_NAME=$(for i in $PKG_NAME; do echo ${i:0:$PKG_NAME_LEN - 1}; done)
		PKG_NAME_LEN=${#PKG_NAME}
		pwd
		printf "${RED}${d}${NC}"
		PULL=$(git pull)
		echo
		printf "${GREEN}${PULL}${NC}"
#		if [ "$PULL" == "Already up to date." ] || [ "$PULL" == *"fatal" ];
#		then
#			cd .. && printf "\n\n"  && continue;
#		fi

		echo
		NEW_VERSION=$(cat PKGBUILD | grep pkgver=)
		NEW_VERSION_LEN=${#NEW_VERSION}
		NEW_VERSION=$(for i in $NEW_VERSION; do echo ${i:7:$NEW_VERSION_LEN}; done)
		printf "New Version Number: ${RED}${NEW_VERSION}${NC}\n"
#		echo

		CURRENT_VERSION=$(pacman -Qe | grep $PKG_NAME)
		echo $CURRENT_VERSION
		CURRENT_VERSION_LEN=${#CURRENT_VERSION}
		echo $CURRENT_VERSION_LEN
		CURRENT_VERSION=$(for i in $CURRENT_VERSION; do echo ${i:$PKG_NAME_LEN:$CURRENT_VERSION_LEN}; done)
		echo $CURRENT_VERSION
		printf "Current Version Number: ${BLUE}${CURRENT_VERSION}${NC}"
		echo



		echo
		PKG=$(cat PKGBUILD)
		printf "${BLUE}${PKG}${NC}"
		echo
		read -p "Would you like to update $PKG_NAME ? " -n 1 -r
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			echo
			echo "Updating!"
			makepkg -sirc
		else
			echo
			echo "Not updating!"
		fi
		cd ..;
done
