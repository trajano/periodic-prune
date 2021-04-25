FROM alpine
COPY --chown=bin prune.sh /prune
RUN apk add -U curl && chmod 700 /prune
USER bin
CMD /prune
