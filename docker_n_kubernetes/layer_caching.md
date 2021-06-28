# Layers catching

Originally what happens is, after a different step all next steps are run again, and don't benefit from cache, from example a source code change triggers npm install again, if npm install is after

For eg. to not repeat the npm install step, put that step before the step that changes frequently, for eg our source code

```dockerfile
FROM node:latest
WORKDIR /app
ADD package*.json .
RUN npm install
ADD . .
CMD node install.js
```

> When using ADD with more than one source file, destination must be directory, so put './' instead of '.' in the ADD step, intentionally won't edit that mistake :)

> Use alpine linux for smaller image sizes

## Tagging old tag as previous version (etc)

```sh
docker tag website:latest website:2
```
