FROM alpine
RUN apk update && apk add git openssh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN addgroup -S torch && adduser -S torch -G torch -s /bin/sh
RUN chown -R torch:torch /github/home
USER torch
ENTRYPOINT ["/entrypoint.sh"]
