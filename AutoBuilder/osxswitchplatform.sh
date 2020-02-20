#!/usr/bin/env bash
 
# USAGE:
# $ ./osxswitchplatform.sh <android>|<ios>

# Make sure Unity isn't running while we switch directories out from under it.
if [ "$(pidof Unity)" ]; then
	echo "Please quit Unity and Unity Hub first"
	exit 199
fi

# Only allow 1 parameter
if [ $# -ne 1 ] ; then
	echo "[osxswitchplatform] Only ONE Parameter expect"
	echo "$ ./osxswitchplatform.sh <android>|<ios>"
	exit 198
fi

# Only accept 'ios' or 'android'
if [ "$1" != "ios" ] && [ "$1" != "android" ] ; then
	echo "[osxswitchplatform] Parameter invalid!"
	echo "$ ./osxswitchplatform.sh <android>|<ios>"
	exit 197
fi

cd ..

# Make sure there is no Library directory.
rm -rf ./Library

# Link Library to platform directory
PLATFORM_DIR="${1}Library"

if [ ! -d $PLATFORM_DIR ] ; then
  mkdir $PLATFORM_DIR
fi

ln -s $PLATFORM_DIR Library
