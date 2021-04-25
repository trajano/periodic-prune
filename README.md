# Docker Periodic Prune

This container runs a shell script that prunes stopped containers.  It executes something akin to `docker container prune -f` every hour.  It is configured to only do it for containers that are older than 30 minutes.

    docker run -d --restart=always -v //var/run/docker.sock:/var/run/docker.sock --name periodic-prune trajano/periodic-prune

This helps having to remember to clean up what could be gigs of space that are left over when testing on local containers.
