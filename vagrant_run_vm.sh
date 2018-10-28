#!/bin/bash

set -e

vagrant_image="${1}"


#### Functions

function usage () {
	cat << EOF
USAGE $0 -i vagrant/image -n name
EOF

}



#### Args management
OPTIND=1

while getopts "h?i:n:" opt; do
    case "$opt" in
    h|\?)
        usage
        exit 0
        ;;
    i)  vagrant_image=$OPTARG
        ;;
    n)  name=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

# check validity
if [ -z "${name}" -o -z "${vagrant_image}" ]; then 
	echo "ERROR while args parsing"
	usage
	exit 1
fi


#### Main
fold="vms/${name}"
echo "--> Create Dir ${fold}"
mkdir -p "${fold}"

pushd "${fold}"

echo "--> vagrant init ${vagrant_image}"
if [ -f "Vagrantfile" ]; then 
	echo "# Vagrant file detected, do not init again"
else
	vagrant init "${vagrant_image}"
fi

echo "--> vagrant up ${name}"
vagrant up

popd
