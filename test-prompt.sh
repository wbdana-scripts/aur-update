read -p "$(printf "${LIGHTRED}//=> Please enter the path to your AUR package directory${NC}\ne.g., ~/aur-packages \n")" shell_configuration_file
echo $shell_configuration_file
sed -i "2i export PATH=\$HOME/.aur-update:\$PATH # Source aur-update command" $shell_configuration_file
head $shell_configuration_file
sleep 3
. $shell_configuration_file

echo Modifying permissions
chmod +x install.sh aur-update
echo Permissions modified

# Issue is that sed and source require an absolute path
# read -p approach seems to not interpret `~` when passed to sed or source