FROM ten7/flight-deck-web:latest
MAINTAINER tess@ten7.com


# Update and install.
USER root
RUN apk -U upgrade && \
    apk add --update --no-cache imagemagick \
    && \
    rm -rf /tmp/* \
           /var/cache/apk/*

# This has to be re-run on each variant image, apparently.
RUN setcap cap_net_bind_service=+ep /usr/sbin/httpd

USER apache
