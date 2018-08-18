RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
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
		printf "${RED}${d}${NC}\n"
		PULL=$(git pull)
		if [ "$PULL" == "Already up to date." ]; #|| [ "$PULL" == *"fatal" ];
		then
			printf "${GREEN}${PULL}${NC}"
		else
			cd .. && printf "\n\n"  && continue;
		fi

		echo
		NEW_VERSION=$(cat PKGBUILD | grep -m 1 "pkgver=")
		NEW_VERSION_LEN=${#NEW_VERSION}
		NEW_VERSION=$(for i in $NEW_VERSION; do echo ${i:7:$NEW_VERSION_LEN}; done)
		NEW_VERSION_LEN=${#NEW_VERSION}
		# printf "New Version Number:     ${RED}${NEW_VERSION}${NC}\n"

		PACMAN_OUTPUT=$(pacman -Qe | grep $PKG_NAME)
		CURRENT_VERSION=${PACMAN_OUTPUT:PKG_NAME_LEN}
		CURRENT_VERSION_LEN=`echo -n $CURRENT_VERSION | wc -m`
		if [[ $CURRENT_VERSION =~ .*-.* && "$CURRENT_VERSION_LEN" -ne "$NEW_VERSION_LEN" ]]; then
			DIFF=`expr $NEW_VERSION_LEN - $CURRENT_VERSION_LEN`
			CURRENT_VERSION=${CURRENT_VERSION:0:DIFF}
			CURRENT_VERSION_LEN=`echo -n $CURRENT_VERSION | wc -m`
		fi

		# Why are these not equal...?
		if [[ $CURRENT_VERSION == $NEW_VERSION ]]; then
			echo TRUE
			echo $CURRENT_VERSION_LEN
			echo $NEW_VERSION_LEN
			printf "New Version Number:     ${GREEN}${NEW_VERSION}${NC}\n"
			printf "Current Version Number:${GREEN}${CURRENT_VERSION}${NC}\n"
		else
			echo FALSE
			echo $CURRENT_VERSION_LEN
			echo $NEW_VERSION_LEN
			printf "New Version Number:     ${RED}${NEW_VERSION}${NC}\n"
			printf "Current Version Number:${YELLOW}${CURRENT_VERSION}${NC}\n"
		fi


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
