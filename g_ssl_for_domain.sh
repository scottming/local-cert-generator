#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "g <domian name> <path>"
else
    echo "generate crt file for $1"
    echo "------------------------"
    sed "s/localhost/$1/" v3.ext > v3.ext1
    mkdir -p $2/envfiles
	openssl req -new -sha256 -nodes -out ssl.csr -newkey rsa:2048 -keyout ssl.key -config server.csr.cnf
	openssl x509 -req -in ssl.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out ssl.crt -days 500 -sha256 -extfile v3.ext1
    echo "------------------------"
	echo "mv to $2/envfiles"
	mkdir -p /tmp/ssl
	mv ssl.crt ssl.csr ssl.key "$2/envfiles"
fi


