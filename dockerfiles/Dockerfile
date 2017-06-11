FROM ruby:2.4.1-slim
MAINTAINER Louis T. <louis@negonicrac.com>

ENV PHANTOMJS_VERSION=2.1.1
ARG PHANTOMJS_DOWNLOAD=phantomjs-$PHANTOMJS_VERSION-linux-x86_64
ARG PHANTOMJS_DOWNLOAD_URL=https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS_DOWNLOAD.tar.bz2

RUN apt-get update \
    \
    # Install build dependencies
    && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      git \
    \
    # Ensure communication with PostgreSQL (libpq-dev)
    && apt-get install -y --no-install-recommends \
      libpq-dev \
    \
    # Install PhantomJS dependencies
    && apt-get install -y --no-install-recommends \
      libfontconfig \
      libfreetype6 \
    \
    # Install PhantomJS
    && curl -sL $PHANTOMJS_DOWNLOAD_URL | tar -xj \
      && mv $PHANTOMJS_DOWNLOAD /opt/phantomjs-$PHANTOMJS_VERSION \
      && ln -s /opt/phantomjs-$PHANTOMJS_VERSION /opt/phantomjs \
      && ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs \
      && phantomjs -v \
    \
    # Install Node.js repository
    && curl -sL https://deb.nodesource.com/setup_7.x | bash - \
      && apt-get install -y --no-install-recommends \
        nodejs \
    \
    # Install Yarn: https://yarnpkg.com/en/docs/install
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
        tee /etc/apt/sources.list.d/yarn.list \
      && apt-get install -y --no-install-recommends \
        yarn \
    \
    # cleanup
    && apt-get purge -y --auto-remove \
      curl \
    && apt-get autoremove -yqq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
    # Install deployment tools
    && gem install dpl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
