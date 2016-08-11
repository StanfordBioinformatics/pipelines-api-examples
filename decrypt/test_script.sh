#!/bin/bash

echo "Docker test run.  GM 2016/8/9"

echo "Reading from bucket"

gsutil cat gs://gbsc-gcp-project-mvp-va_aaa/misc/test_file.txt

echo "Copying contents to local file"
gsutil cat gs://gbsc-gcp-project-mvp-va_aaa/misc/test_file.txt > local_file.txt

cat local_file.txt
