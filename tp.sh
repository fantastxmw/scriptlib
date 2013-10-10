#!/bin/sh

TEMP_FOLDER="temp"

if [ $# == 2 ]; then
	PACKED_FOLDER=`pwd`/$2/
else
	PACKED_FOLDER=`pwd`/$1"_packed"
fi

function pack()
{
	TexturePacker --data $PACKED_FOLDER/$2_$3.plist --sheet $PACKED_FOLDER/$2_$3.pvr.ccz --premultiply-alpha --opt RGBA4444 --size-constraints NPOT --content-protection 6403fbcd23770e48457636bb17eea693 $1
}

function packAction()
{
	ACTION_FOLDER=$1/$2
	mkdir -p $TEMP_FOLDER/$ACTION_FOLDER

	cp -r $ACTION_FOLDER/* $TEMP_FOLDER/$ACTION_FOLDER

	pack $TEMP_FOLDER $1 $2

	rm -Rf $TEMP_FOLDER
}

# echo $1

ROOT_FOLDER=$1

cd $1

if [ ! -d $TEMP_FOLDER ]; then
	mkdir -p $TEMP_FOLDER
fi

if [ ! -d $PACKED_FOLDER ]; then
	mkdir -p $PACKED_FOLDER
fi

# echo `pwd`
for folder in *; do
	if [ $folder == $TEMP_FOLDER ]; then
		continue
	fi

	if [ -d $folder ]; then
		packAction $folder "01"
		packAction $folder "02"
		packAction $folder "03"
		packAction $folder "04"
		packAction $folder "05"
		packAction $folder "06"
		packAction $folder "07"
		packAction $folder "08"
		packAction $folder "09"
	fi
	# break
done

rm -rf $TEMP_FOLDER