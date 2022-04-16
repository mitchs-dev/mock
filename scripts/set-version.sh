#!/bin/bash
source scripts/versioning.env
VERSION_CMD='cmd/version.go'
CURRENT_DATE=`date`

# -s <VERSION> can be used to set version
while getopts "s:" arg; do
  case $arg in
    s) CURRENT_VERSION=`echo v$OPTARG`;;
  esac
done

# Sets Version
if [[ $CURRENT_VERSION == $OLD_VERSION ]]; then
   echo "WARNING: Current and Old versions are the same."
   echo "Current: $CURRENT_VERSION"
   echo "Old: $OLD_VERSION"
   echo "This must be fixed before continuing."
   exit 1
fi
sed -i 's/'"$SET_TIMESTAMP"'/'"$CURRENT_DATE"'/g' $VERSION_CMD
sed -i 's/'"$SET_TIMESTAMP"'/'"$CURRENT_DATE"'/g' scripts/versioning.env
echo "--> Time set"
sed -i 's/'"$OLD_VERSION"'/'"$CURRENT_VERSION"'/g' $VERSION_CMD
sed -i 's/'"$OLD_VERSION"'/'"$CURRENT_VERSION"'/g' scripts/versioning.env
echo "--> Version set"
echo "Completed"
