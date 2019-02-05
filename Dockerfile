FROM ruby:2.6.1-alpine3.9
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
	&& bundle config --global build.nokogiri  "--use-system-libraries" \
	&& bundle config --global build.nokogumbo "--use-system-libraries" \
	&& yarn global add heroku \
	&& find / -type f -iname \*.apk-new -delete \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /usr/lib/lib/ruby/gems/*/cache/* \
	&& mkdir -p $APP_ROOT \
	&& gem install dpl

WORKDIR $APP_ROOT
