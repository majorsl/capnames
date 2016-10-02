#!/bin/sh
# version 1.0.1
# This script will capitalize the first letter of every file and directory in the
# path given. You can list specific files within the script and use -m to exclude them.

STARTDIR=$1
EXCLUDE=$2

if [ "$STARTDIR" = "" ] || [ "$STARTDIR" = "?" ] || [[ "$STARTDIR" = *-h* ]]; then
	ECHO ""
	ECHO "Usage: capnames.sh <directorypath> to parse. <-m>"
	ECHO "-m to exclude specific files listed in the script."
	ECHO ""
	exit
fi

#Here we set BASHs internal IFS variable so directories/filenames are not broken into new lines when a space is found.
IFS=$'\n'
cd $STARTDIR
FILES="*"
for F in $FILES
do
  PROCESS=""
  VARCAP=$(echo "${F}" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
  
  #Here we can exclude names from the process.
  if [ "$EXCLUDE" = "-m" ]; then
  	if [ "$F" = "folder.jpg" ] || [ "$F" = "fanart.jpg" ] || [ "$F" = "season-all.jpg" ] || [ "$F" = "tvshow.nfo" ] || [ "$F" = "thumbs.db" ]; then
  	VARCAP="$F"
  	PROCESS="NOT "
    fi
  fi
  
  echo $PROCESS"Processing $F file..."
  mv $F $VARCAP
done
unset IFS
