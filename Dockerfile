FROM ruby:2.7.6-alpine3.16
MAINTAINER Louis Taylor <louis@negonicrac.com>

ENV APP_ROOT /usr/src/app

RUN \
	apk add --no-cache --update --upgrade --virtual .railsdeps \
		build-base \
		git \
		\
		bzip2-dev \
		libgcrypt-dev \
		libxml2-dev \
		libxslt-dev \
		# libressl-dev \
		postgresql-dev \
		sqlite-dev \
		zlib-dev\
		\
		ca-certificates \
		tzdata \
		yarn \
		\
		openssh \
		\
		curl \
		bash

RUN curl https://cli-assets.heroku.com/install.sh | sh

RUN bundle config --global build.nokogiri  "--use-system-libraries" \
	&& bundle config --global build.nokogumbo "--use-system-libraries" \
	&& find / -type f -iname \*.apk-new -delete \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /usr/lib/lib/ruby/gems/*/cache/* \
	&& mkdir -p $APP_ROOT \
	&& gem install dpl

WORKDIR $APP_ROOT
