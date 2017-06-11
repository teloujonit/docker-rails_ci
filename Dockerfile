FROM ruby:2.4.1-slim
MAINTAINER Louis T. <louis@negonicrac.com>

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      git \
    && rm -rf /var/lib/apt/lists/*

# Ensure communication with PostgreSQL (libpq-dev)
RUN apt-get update && apt-get install -y --no-install-recommends \
      libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PhantomJS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfontconfig \
    libfreetype6 \
  && rm -rf /var/lib/apt/lists/*

# Install PhantomJS
ENV PHANTOMJS_VERSION=2.1.1
RUN curl -sL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 | tar -xj
RUN mv phantomjs-$PHANTOMJS_VERSION-linux-x86_64 /opt/phantomjs-$PHANTOMJS_VERSION
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION /opt/phantomjs \
    && ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs \
    && phantomjs -v

# Add Node.js repository
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

# Add Yarn repository: https://yarnpkg.com/en/docs/install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
      tee /etc/apt/sources.list.d/yarn.list

# Install Yarn and Node.js
RUN apt-get update && apt-get install -y --no-install-recommends \
      nodejs \
      yarn \
    && apt-get purge -y --auto-remove curl \
    && apt-get autoremove -yqq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

# Install deployment tools
RUN gem install dpl

RUN ruby -v
