
#!/bin/bash

curDate=$(date +"%Y-%m-%d")
prevDate=$(date -d "now -7 days" +"%Y-%m-%d")
backupDir=/home/user/
dir=""
log=/home/user/backup-report

for file in $(ls $backupDir | grep "Backup-"); do
  date=$(echo $file | sed "s/Backup-//g")
  if [[ $date > $prevDate ]]; then
    dir="Backup-$date"
  fi
done

if [ -z "$dir" ]; then
  dir="Backup-$curDate"
  mkdir "$backupDir$dir"
  echo "$curDate: $backupDir$dir was created" >> $log
  for file in $(ls /home/user/source);do
    cp "/home/user/source/$file" "$backupDir$dir"
    echo "$curDate: $file was copied to /home/user/source/" >> $log
  done
else
  for file in $(ls /home/user/source); do
    if ! [ -e "$backupDir$dir/$file" ]; then
      cp "/home/user/source/$file" "$backupDir$dir"
    else
      oldSize=$(wc -c "$backupDir$dir/$file" | awk '{ print $1 }')
      curSize=$(wc -c "/home/user/source/$file" | awk '{ print $1 }')
      if [[ $curSize != $oldSize ]]; then
        mv "$backupDir$dir/$file" "$backupDir$dir/$file.$curDate"
        cp "/home/user/source/$file" "$backupDir$dir"
        echo "$curDate: make changes" >> $log
        echo "$file was copied to /home/user/source/" >> $log
        echo "$backupDir$dir$file was renamed to $file.$curDate" >> $log
      fi
    fi
  done
fi
