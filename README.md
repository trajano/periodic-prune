# Docker Periodic Prune

This container runs a cron job that executes something akin to `docker container prune -f` every hour.  It is configured to only do it for containers that are older than 30 minutes.


    docker run -d --restart=always -v //var/run/docker.sock:/var/run/docker.sock trajano/periodic-prune

