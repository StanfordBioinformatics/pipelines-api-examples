# Pipelines API Demo

This document covers the basics of how to use the Google Genomics Pipelines API

## Docker

Check that docker is up and running

```
docker help
```

Get the base ubuntu image

```
docker pull ubuntu
```

Open up an interactive shell for the ubuntu image
```
docker run -ti ubuntu /bin/bash
```

Set up some stuff

```
root@ea0171fc4b03:/# apt-get update
root@ea0171fc4b03:/# apt-get install vim
root@ea0171fc4b03:/# cd bin
root@ea0171fc4b03:/bin# vi test_script.sh
```

Paste the following into the script

```
#!/bin/bash
echo "I'm in the cloud!" > /mnt/data/output/test_output.txt
```

Set the permissions on the new script

```
root@ea0171fc4b03:/bin# chmod 777 test_script.sh
```

Exit out of the image

```
root@ea0171fc4b03:/bin# exit 
```

Notice the hash in the command line `ea0171fc4b03`, we need to copy this once we've left the image to commit it.  It may be different for you.

```
docker commit -m "Test pipeline" -a "gm" ea0171fc4b03 greg/pipeline_demo:v1
```

We need a special tag for the image in order to push it into the Google Container Repository
```
docker tag greg/pipeline_test:v1 gcr.io/gbsc-gcp-project-mvp/pipeline_demo
```

Now we can push it to Google

```
gcloud docker push gcr.io/gbsc-gcp-project-mvp/pipeline_demo
```

## Pipelines API

Once we have our custom image set we can run the pipeline using the Pipelines API

```
PYTHONPATH=.. python ./run_demo.py  \
     --project gbsc-gcp-project-mvp   \
     --zones "us-central1-a"   \
     --disk-size 200   \
     --output gs://gbsc-gcp-project-mvp-va_aaa/misc/output/   \
     --logging gs://gbsc-gcp-project-mvp-va_aaa/misc/output/logging   \
     --poll-interval 10
```

