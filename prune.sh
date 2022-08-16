#!/bin/sh
set -e
curl -s --output /dev/null --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/containers/prune?filters=%7B%22until%22%3A%5B%22${CONTAINER_UNTIL}%22%5D%7D

name_prefix=R${RANDOM}
for image in $EXCLUSIONS
do
  name=${name_prefix}_$(echo $image | sha1sum | awk '{ print $1 }')
  curl -s --output /dev/null --output /dev/null --no-buffer -XPOST --unix-socket /var/run/docker.sock -H "Content-Type: application/json" --data "{ \"Image\": \"${image}\" }" http://localhost/containers/create?name=${name}
done
curl -s --output /dev/null --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/images/prune?filters=%7B%22until%22%3A%5B%22${IMAGE_UNTIL}%22%5D%2C%22dangling%22%3A%5B%221%22%5D%7D
curl -s --output /dev/null --no-buffer -XPOST --unix-socket /var/run/docker.sock http://localhost/images/prune?filters=%7B%22until%22%3A%5B%22${IMAGE_ALL_UNTIL}%22%5D%2C%22dangling%22%3A%5B%220%22%5D%7D
for image in $EXCLUSIONS
do
  name=${name_prefix}_$(echo $image | sha1sum | awk '{ print $1 }')
  curl -s --output /dev/null --no-buffer -XDELETE --unix-socket /var/run/docker.sock http://localhost/containers/${name}
done
