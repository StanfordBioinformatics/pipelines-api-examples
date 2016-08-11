# Cloud Decryption
This document covers how to decrypt files in Google Storage.  This document and all scripts were written with the intent of decrpting files delivered from Bina but should be general enough to decrypt any files encrypted with PGP.  This pipeline will decrypt and unpack contents of an encrypted file and write results to a directory within Google Storage.

### Quickstart

Get a local copy of the GITHUB REPO 
Make sure you are authenticated with the Google project.  (Ask Keith if you don’t know what this means)
Within your local copy of the repository, navigate to the decrypt directory

```
cd decrypt
```


Execute the command to launch the decrypt pipeline.  The order of the inputs is important.  Make sure the file to be decrypted is the first file listed.  The following files are the keys needed to perform the decryption.  *NOTE* If you are putting new keys somewhere, make sure they are in a private bucket.

```
PYTHONPATH=.. python ./run_decrypt.py  \
   --project gbsc-gcp-project-mvp   \
   --zones "us-central1-a"   \
   --disk-size 200   \
   --input gs://PATH/TO/INPUT/FILE.tar.pgp   gs://PATH/TO/pair.asc gs://PATH/TO/passphrase.txt \
   --output gs://PATH/TO/output/   \
   --logging gs://PATH/TO/output/logging   \
   --poll-interval 10 
```

Navigate to the output directory to make sure the job finished successfully.

### Docker Image
The Docker image used for this process is the standard ubuntu image with a custom script placed in the bin.  

The Docker image can be found in the Google Container Repository linked to the VA project:

gcr.io/gbsc-gcp-project-mvp/gs_decrypt

The contents of the script are here:

```
#!/bin/bash

encrypted_file=$1
encrypted_file_id=`echo $encrypted_file | cut -f1 -d.`

# Decrypt
gpg --import /mnt/data/input/pair.asc
gpg --batch --yes --passphrase-file /mnt/data/input/passphrase.txt \
--output /mnt/data/output/$encrypted_file_id.tar \
--decrypt /mnt/data/input/$encrypted_file

# Unpack
tar -xvf /mnt/data/output/$encrypted_file_id.tar -C /mnt/data/output/
```

### Encryption Keys

The keys for the Bina project have been stored here:

gs://gbsc-gcp-project-mvp-va_aaa/misc/keys/

Don’t share these publicly.  

If for whatever reason the keys change in the future you can make a new key directory and place them there.  Change the inputs to reflect the new keys.  Keep the names (pair.asc, passphrase.txt) the same and the pipeline will continue to work.
