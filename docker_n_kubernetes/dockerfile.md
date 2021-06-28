# Dockerfile

* Build own images
* Should contain 'everything' that the container needs to run

Dockerfile ---(create)---> Image ---(run)---> Container

## Docker Image

* Image is a template for creating an environment of choice
* Snapshot
* Has everything needed to run apps
* OS, Software, Source code

For eg. while in the website source code folder, this basic dockerfile ->

```dockerfile
FROM nginx:latest
ADD . /usr/share/nginx/html
```

That's it, and we won't need to use the volumes, since this already copies all the static source code in correct location (same as what we mounted volume to)

Then `docker build --tag myimage` _(Optionally pass name:tag)_

> Each step creates a layer that is cached by docker

### .dockerignore

Similar to .gitignore

For example...
```
node_modules
Dockerfile
.git
```

