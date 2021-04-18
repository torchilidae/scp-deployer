FROM alpine
RUN apk update && apk add git openssh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN addgroup -S torch && adduser -S torch -G torch -s /bin/sh
RUN mkdir -p /home/torch && chown -R torch:torch /home/torch
USER torch
WORKDIR /home/torch
ENTRYPOINT ["/entrypoint.sh"]
