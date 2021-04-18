FROM alpine
RUN apk update && apk add git openssh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN addgroup -S gitgroup && adduser -S gituser -G gitgroup -s /bin/sh
USER gituser
WORKDIR /home/gituser
ENTRYPOINT ["/entrypoint.sh"]
