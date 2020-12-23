#!/bin/bash

from=/home/user
to=/home/user/restore/

maxDate="1970-01-01"
for file in $(ls $from | grep "Backup-"); do
  date=$(echo $file | sed "s/Backup-//")
  if [[ $date > $maxDate ]]; then
    maxDate=$date
  fi
done

if [[ maxDate != "1970-01-01" ]]; then
  for file in $(ls "$from/Backup-$maxDate" | grep -v -E "*.[0-9]{4}-[0-9]{2}-[0-9]{2}$"); do
    cp "$from/Backup-$maxDate/$file" "$to"
  done
fi
