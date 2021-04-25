#!/bin/sh
watch -t -n 3600 curl -s -q -o /dev/null --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/containers/prune?filters=%7B%22until%22%3A%5B%2230m%22%5D%7D
