#!/bin/sh
curl --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/containers/prune?filters=%7B%22until%22%3A%5B%2230m%22%5D%7D
curl --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/images/prune?filters=%7B%22until%22%3A%5B%222h%22%5D%2C%22dangling%22%3A%5B%221%22%5D%7D
curl --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/images/prune?filters=%7B%22until%22%3A%5B%2248h%22%5D%2C%22dangling%22%3A%5B%220%22%5D%7D
