
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
