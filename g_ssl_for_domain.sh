#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "g <domian name> <path>"
else
    echo "generate crt file for $1"
    echo "------------------------"
    sed "s/localhost/$1/" v3.ext > v3.ext1
	openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config server.csr.cnf
	openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 500 -sha256 -extfile v3.ext1
    echo "------------------------"
	echo "mv to $2"
	mkdir -p /tmp/ssl
	mv server.crt server.csr server.key "$2"
fi


