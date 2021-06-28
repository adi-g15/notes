## Managing containers

After stopping container, we could start it again.

### 'Removing' container ('rm')

Use 'docker rm' to remove one.

To delete every container, 
Just pass the output of $(docker ps -a --quiet) to docker rm

> Can't remove a running container; Use -f to force deleting such too

## Getting console inside a running container

`docker exec -it mycontainer bash`

> the -t option is short for --tty

