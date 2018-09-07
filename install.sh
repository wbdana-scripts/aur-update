#!/bin/bash

# DESTINATION="/bin/aur-update"
# mkdir -p ${DESTINATION}

# ARCHIVE=$(awk '/^__ARCHIVE__/ {print NR + 1; exit 0;}' "${0}")
# tail -n${ARCHIVE} ${0} | tar xpJv -C ${DESTINATION}

# Prompt user for path to AUR package directory
read -p "$(printf "//=> Please enter the path to your AUR package directory\ne.g., ~/aur-packages\n")" aurpath

# Append the path to aur.sh
sed -i "2i AURPATH=${aurpath}" ./aur.sh

echo "AUR-Update installation complete."

exit 0

# __ARCHIVE__