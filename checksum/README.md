# Checking Checksums

The scripts in this directory utilize the Pipelines API to check checksums in the cloud.  SHA1 and md5sums hashes are currently supported.  

```
PYTHONPATH=.. python ./run_checksum.py 
    --project PROJECT_NAME \ 
    --zones "us-central1-a" \ 
    --disk-size 200 \ 
    --operation md5sum \ # must be md5sum or sha1sum
    --input gs://PATH/TO/CHECKSUM gs://PATH/TO/FILE \
    --output gs://PATH/TO/OUTPUT/DIR \
    --logging gs://PATH/TO/LOGGING/DIR 
```

A file will be copied to the output directory with the results of the check.  The file will be names INPUT_FILENAME.check.
