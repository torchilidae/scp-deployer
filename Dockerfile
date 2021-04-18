FROM alpine
RUN apk update && apk add git openssh
RUN addgroup -S gitgroup && adduser -S gituser -G gitgroup -s /bin/sh
USER gituser
WORKDIR /home/gituser
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
