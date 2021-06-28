# Volumes

* Allows sharing of data.
* Between host and containers

Use "-v 'from host':'in docker':ro", for eg. `-v /home/adityag/website:/usr/share/nginx/html:ro` to mount a directory on our host to inside a location in the docker

> Removing the :ro defaults to read write

## Sharing volumes 'between' containers

Use the '--volumes-from' option to docker run

For eg. docker run --name website-two --volumes-from -p ... nginx

