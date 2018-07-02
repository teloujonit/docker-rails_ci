FROM ruby:2.5.1-alpine3.7
MAINTAINER Louis Taylor <louis@negonicrac.com>

ENV APP_ROOT /usr/src/app

RUN \
	apk add --no-cache --update --upgrade --virtual .railsdeps \
		# BUILD_PACKAGES
		build-base git \
		# DEV_PACKAGES
		bzip2-dev libgcrypt-dev libxml2-dev libxslt-dev libressl-dev \
		postgresql-dev sqlite-dev zlib-dev\
		# RAILS_DEPS
		ca-certificates yarn tzdata \
	&& bundle config --global build.nokogiri  "--use-system-libraries" \
	&& bundle config --global build.nokogumbo "--use-system-libraries" \
	&& yarn global add heroku-cli \
	&& find / -type f -iname \*.apk-new -delete \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /usr/lib/lib/ruby/gems/*/cache/* \
	&& mkdir -p $APP_ROOT \
	&& gem install dpl

WORKDIR $APP_ROOT
