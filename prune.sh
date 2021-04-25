#!/bin/sh
curl -s --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/containers/prune?filters=%7B%22until%22%3A%5B%22${CONTAINER_UNTIL}%22%5D%7D
curl -s --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/images/prune?filters=%7B%22until%22%3A%5B%22${IMAGE_UNTIL}%22%5D%2C%22dangling%22%3A%5B%221%22%5D%7D
curl -s --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/images/prune?filters=%7B%22until%22%3A%5B%22${IMAGE_ALL_UNTIL}%22%5D%2C%22dangling%22%3A%5B%220%22%5D%7D
