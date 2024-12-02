FROM alpine:3
LABEL maintainer="Mansoor <github@esc.sh>"

#remove after upgrade on alpine >3.20
#fix for CVE-2024-39894
RUN apk add openssh --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main  \
   && rm -rf /var/cache/apk/*

RUN apk add --no-cache --virtual .run-deps rsync tzdata curl ca-certificates \
  && rm -rf /var/cache/apk/*

RUN addgroup -S rsyncuser && adduser -S rsyncuser -G rsyncuser

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]
