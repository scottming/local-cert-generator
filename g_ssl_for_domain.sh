#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "g <domian name> <path>"
else
    echo "generate crt file for $1"
    echo "------------------------"
    mkdir -p $2
    sed "s/localhost/$1/" v3.ext > v3.ext1
	openssl req -new -sha256 -nodes -out ssl.csr -newkey rsa:2048 -keyout ssl.key -config server.csr.cnf
	openssl x509 -req -in ssl.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out ssl.crt -days 500 -sha256 -extfile v3.ext1
    echo "------------------------"
	echo "mv to $2"
	mkdir -p /tmp/ssl
	mv ssl.crt ssl.csr ssl.key "$2"
fi


