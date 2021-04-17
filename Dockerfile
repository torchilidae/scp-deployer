FROM alpine
RUN apk update && apk add git openssh
RUN useradd -ms /bin/bash gituser
USER gituser
WORKDIR /home/gituser

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && dos2unix /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
