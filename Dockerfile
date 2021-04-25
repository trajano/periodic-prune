FROM alpine
COPY prune.sh /prune
RUN apk add -U curl && chmod 700 /prune
ENV CONTAINER_UNTIL=30m \
    IMAGE_UNTIL=2h \
    IMAGE_ALL_UNTIL=48h
CMD [ "watch", "-t",  "-n", "3600" , "/prune" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "-s", "--no-buffer", "--unix-socket", "/var/run/docker.sock", http://localhost/ping ]
