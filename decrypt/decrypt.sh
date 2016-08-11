#!/bin/bash

encrypted_file=$1
encrypted_file_id=`echo $encrypted_file | cut -f1 -d.`

# Decrypt
gpg --import /mnt/data/input/pair.asc
gpg --batch --yes --passphrase-file /mnt/data/input/passphrase.txt \
	--output /mnt/data/output/$encrypted_file_id.tar \
	--decrypt /mnt/data/input/$encrypted_file

# Unpack
tar -xvf /mnt/data/output/$encrypted_file_id.tar -C /mnt/data/output/ --strip-components=2 
