#! /usr/bin/sh

for i in "$@"
do
    ssh-keygen -t rsa -b 2048 -f "$i" -E md5
done

exit 0;