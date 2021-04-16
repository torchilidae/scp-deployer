FROM alpine
RUN apk update && apk add git openssh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && dos2unix /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
