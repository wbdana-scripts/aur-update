# #!/bin/bash

# while getopts "m:" opt; do
#     case $opt in
        # m) multi+=("$OPTARG");;
#         #...
#     esac
# done
# shift $((OPTIND -1))

# echo "The first value of the array 'multi' is '$multi'"
# echo "The whole list of values is '${multi[@]}'"

# echo "Or:"

# for val in "${multi[@]}"; do
#     echo " - $val"
# done
# The output would be:

# $ /tmp/t
# The first value of the array 'multi' is ''
# The whole list of values is ''
# Or:

# $ /tmp/t -m "one arg with spaces"
# The first value of the array 'multi' is 'one arg with spaces'
# The whole list of values is 'one arg with spaces'
# Or:
#  - one arg with spaces

# $ /tmp/t -m one -m "second argument" -m three
# The first value of the array 'multi' is 'one'
# The whole list of values is 'one second argument three'
# Or:
#  - one
#  - second argument
#  - three

while getopts ":a:m:" opt; do
  case $opt in
    a)
      echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
	m)
		multi+=("$OPTARG")
		echo "The first value of the array 'multi' is '$multi'"
		echo "The whole list of values is '${multi[@]}'"
		for val in "${multi[@]}"; do
    		echo " - $val"
		done
		;;
  esac
done
shift $((OPTIND -1))