FROM alpine
COPY prune.sh /prune
RUN apk add -U curl && chmod 700 /prune
CMD [ "watch", "-t",  "-n", "3600" , "/prune" ]
