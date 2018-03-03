FROM alpine:latest
Label maintainer="Wolfereign"

RUN apk add --update --no-cache \ 
    dcron \
    wget \
    rsync \
    curl \
    ca-certificates

RUN mkdir -p /var/log/cron && \ 
    mkdir -m 0644 -p /var/spool/cron/crontabs && \
    touch /var/log/cron/cron.log && \
    mkdir -m 0644 -p /etc/cron.d

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD ["su", "-c", "/usr/sbin/crond -f -d 8"]
