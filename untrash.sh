#!/bin/bash

untrashFile=$1
trashDir=/home/.trash
logFile=/home/.trash.log

if ! [ -d $trashDir ] 
then
echo "There is no trash bin on your computer"
return -1
fi
if ! [ -f $logFile ]
then
echo "There is no trash.log on your computer"
return -1
fi
logData=$(grep "/$untrashFile|" $logFile)
for line in $logData
do
nameInTrash=$(echo $line | cut -d "|" -f2)
filePath=$(echo $line | cut -d "|" -f1)
command=null
while ! [[ "$command" == Y || "$command" == N ]]
do
echo "Do you want to untrash $filePath? [Y/N]"
read command
done
if [[ "$command" == Y ]]
then
dir="$(dirname $filePath)"
if ! [ -e $dir ]
then
echo "$dir doesn't exist, trying to untrash your file into /home"
dir=/home
fi

fileName=$untrashFile
while [ -f "$dir/$fileName" ]
do
echo "$fileName already exits, type another name:"
read fileName
echo $fileName
done
ln "$trashDir/$nameInTrash" "$dir/$fileName"
rm "$trashDir/$nameInTrash"
break
fi
done
