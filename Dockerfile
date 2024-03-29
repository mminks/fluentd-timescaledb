FROM fluentd:latest

LABEL maintainer="Meik Minks <mminks@inoxio.de>"

ENV LD_LIBRARY_PATH "/usr/lib"

USER root

RUN apk add --no-cache \
        postgresql-dev \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
        gnupg \
    && echo 'gem: --no-document' >> /etc/gemrc \
    && gem install fluent-plugin-timescaledb -v 1.0.1 \
    && gem install fluent-plugin-concat -v 2.4.0 \
    && gem install fluent-plugin-bigquery \
    && gem install bigdecimal \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
