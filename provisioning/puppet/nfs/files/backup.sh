#! /usr/bin/sh

BACKUP="/backup/$(date +"%Y%m%d%h")"
echo $BACKUP
rsync -azvv / "$BACKUP" && gzip -9c "$BACKUP" > "$BACKUP.gz"
du -sh "$BACKUP" | [[ $(cut -f1) -eq 0 ]] && rm -vf "$BACKUP"
du -sh -B 1G /backup | [[ $(cut -f1) -gt $1 ]] && ls -t | tail -1 | rm -vf

exit 0;
