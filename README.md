# Docker Periodic Prune

This container runs a shell script that prunes stopped containers.  This helps having to remember to clean up what could be gigs of space that are left over when testing on local containers.  The script executes every hour and does something similar the following via Docker socket.

* `docker container prune -f` for containers that are older than 30 minutes.  Overriden by `CONTAINER_UNTIL` environment variable.
* `docker image prune -f` for images that are older than 2 hours.  Overriden by `IMAGE_UNTIL` environment variable.
* `docker image prune -f --all` for images that are older than 2 days.  Overriden by `IMAGE_ALL_UNTIL` environment variable.

To run this.

    docker run -d --restart=always -v //var/run/docker.sock:/var/run/docker.sock --name periodic-prune trajano/periodic-prune

## Developer notes

Testing locally

    docker run -v //var/run/docker.sock:/var/run/docker.sock:ro  `docker build -q  . ` //prune
