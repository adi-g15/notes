# Docker image

* Image is a template for creating an environment of your choice
* Snapshot
* Has **everything** needed to run your Apps
* OS, Software, App Code


> ## Container
> 
> **Running instance of an image**

On docker hub, there are a lot of official images.
It is a resitory

Pulling image -> `docker pull nginx`
See downloaded images -> `docker images`
Running Image -> `docker run nginx:latest`	(When started, we are 'inside' the container)

### List all running containers

* `docker container ls`
* `docker ps` -> _Preferred way_

### Detached mode

Give `-d` in options, to docker run.

## Exposing ports

For eg. nginx by default listens on the tcp port 80

The container is in docker,
we are in host, want to request on port 8080, and should be mapped to port 80 of the 'container' running 'inside docker'

To do this, just add `-p 8080:80`, ie. map 8080 'from host' to 80 'of docker'

> Simply add another -p to map multiple ports, for eg. -p 3000:80 -p 8080:80

