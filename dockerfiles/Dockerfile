FROM ruby:2.4.1-slim
MAINTAINER Louis T. <louis@negonicrac.com>

# Setup locales (fixes encoding issues)
ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV LC_ALL=C.UTF-8
# RUN locale

ENV PHANTOMJS_VERSION=2.1.1
ENV PHANTOMJS_FOLDER=phantomjs-$PHANTOMJS_VERSION
ENV PHANTOMJS_LINUX=$PHANTOMJS_FOLDER-linux-x86_64
ENV PHANTOMJS_DOWNLOAD_URL=https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS_LINUX.tar.bz2

RUN apt-get update \
    \
    # Install build dependencies
    && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      grep \
      git \
      wget \
    \
    # Install curb gem dependencies
    && apt-get install -y --no-install-recommends \
      libcurl3 \
      libcurl3-gnutls \
      libcurl4-openssl-dev \
    \
    # Install ssh-agent
    && apt-get install -y --no-install-recommends \
      openssh-client \
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
      && mv $PHANTOMJS_LINUX /opt/$PHANTOMJS_FOLDER \
      && ln -s /opt/$PHANTOMJS_FOLDER /opt/phantomjs \
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
      && apt-get update && apt-get install -y --no-install-recommends \
        yarn \
    \
    # Install Heroku Toolbelt
    && wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh \
    \
    # cleanup
    && apt-get autoremove -yqq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
    # Install deployment tools
    && gem install dpl \
    && gem install bundler --pre

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
