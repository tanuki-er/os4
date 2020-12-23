#!/bin/bash

trashDir=/home/.trash
numFile=/home/.numbers
logFile=/home/.trash.log

if ! [ -f $1 ]
then
echo "File $1 doesn't exist"
return -1
fi

removeFile=$PWD"/"$1
if ! [ -d $trashDir ]
then
mkdir $trashDir
fi
if ! [ -f $numFile ]
then
touch $numFile
echo 1 > $numFile
fi
if ! [ -f $logFile ]
then
touch $logFile
fi

read nextNumber < $numFile
nextNumber=$((nextNumber + 1))

ln $removeFile "$trashDir/$nextNumber"
rm $removeFile

echo $nextNumber > $numFile
echo "$removeFile|$nextNumber" >> $logFile
