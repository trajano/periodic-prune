# Docker Periodic Prune

This container runs a shell script that prunes stopped containers.  This helps having to remember to clean up what could be gigs of space that are left over when testing on local containers.  The script executes every hour and does something similar the following via Docker socket.

* `docker container prune -f` for containers that are older than 30 minutes.  Overriden by `CONTAINER_UNTIL` environment variable.
* `docker image prune -f` for images that are older than 2 hours.  Overriden by `IMAGE_UNTIL` environment variable.
* `docker image prune -f --all` for images that are older than 2 days.  Overriden by `IMAGE_ALL_UNTIL` environment variable.

To run this.

    docker run -d --restart=always -v //var/run/docker.sock:/var/run/docker.sock:ro --name periodic-prune trajano/periodic-prune

## Exclusions

The image exclusions prevent specific images from being pruned to avoid downloading again.  These are passed in as a white space separated list into the environment.  Quoted values are not supported.

    docker run -d --restart=always -v //var/run/docker.sock:/var/run/docker.sock:ro --name periodic-prune \
      --env EXCLUSIONS="
        alpine
        node:16.16.0
        gradle:7.4-jdk17
        openjdk:17-jdk
        gcr.io/distroless/java17-debian11
      " \
      trajano/periodic-prune

This is implememented by creating containers, but not running them; then executing the prune operation; then removing the temporary containers.  This does not pull if the images are not present.


## Developer notes

Testing locally

    docker run -v //var/run/docker.sock:/var/run/docker.sock:ro  `docker build -q  . ` //prune

    docker run -v //var/run/docker.sock:/var/run/docker.sock:ro  \
      --env EXCLUSIONS="
        alpine
        node:16.16.0
        gradle:7.4-jdk17
        openjdk:17-jdk
        gcr.io/distroless/java17-debian11
      " \
      `docker build -q  . ` \
      //prune
