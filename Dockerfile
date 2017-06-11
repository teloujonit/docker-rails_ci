FROM ruby:2.4.1-slim
MAINTAINER Louis T. <louis@negonicrac.com>

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential \
      curl \
      git

# Ensure communication with PostgreSQL (libpq-dev)
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      libpq-dev

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y --no-install-recommends \
      nodejs

# Install Yarn: https://yarnpkg.com/en/docs/install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
      tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends \
      yarn

# Install PhantomJS
RUN apt-get install -y --no-install-recommends \
    libfontconfig \
    libfreetype6

RUN curl -sL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar -xj \
    && mv phantomjs-2.1.1-linux-x86_64 /opt/phantomjs-2.1.1 \
    && ln -s /opt/phantomjs-2.1.1 /opt/phantomjs \
    && ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs \
    && apt-get autoremove -yqq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    # Checking if phantom works
    && phantomjs -v

RUN ruby -v
RUN gem update
RUN gem install nokogiri
RUN gem install capybara
RUN gem install poltergeist
RUN gem install pry
RUN gem install rspec

# Install deployment tools
RUN gem install dpl
