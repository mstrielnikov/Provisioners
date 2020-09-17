#! /usr/bin/sh

for i in "$@"
do
    openssl genrsa -out "$1.key" 2048 
    openssl req -new -key "$1.key" -out "$1.csr"
    #openssl req -new -newkey rsa:2048 -nodes -keyout "$1.key" -out "$1.csr"
done

exit 0;