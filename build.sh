#!/bin/sh
#build lua scripts

ROOT_PATH=`pwd`/../Compiled
# DIR_NAME=.
function compile()
{
	local DIR_NAME=$1
	# echo $DIR_NAME

	local FOLDER=$ROOT_PATH/$DIR_NAME

	if [ ! -d $FOLDER ]; then
		# echo "create folder at " $FOLDER
		mkdir -p $FOLDER
	fi

	# echo "the path is " $DIR_NAME "\n"

	for file in $DIR_NAME/*; do
		if [ $file == . ]; then
			# echo $file
			continue
		fi

		if [ -d $file ]; then
			compile $file
		elif [ -f $file -a "${file##*/}" = "configuration.lua" ]; then
			# cp -f $file $ROOT_PATH/$file
			echo $file "is skipped"
		elif [ -f $file -a "${file##*.}" = "lua" ]; then
			# echo $file
			# cp -fv $file $FOLDER
			luajit -b $file $ROOT_PATH/$file
		fi
	done	

	# echo $DIR_NAME " \n"
}

compile .
