FROM ruby:2.2.1
MAINTAINER Matt Darby <matt.darby@rackspace.com>
RUN apt-get update && apt-get install -y \
  autoconf \
  automake \
  bison \
  build-essential \
  curl \
  g++ \
  gawk \
  gcc \
  libc6-dev \
  libffi-dev \
  imagemagick \
  libgdbm-dev \
  libncurses5-dev \
  libpq-dev \
  libreadline6-dev \
  libsqlite3-dev \
  libssl-dev \
  libtool \
  libyaml-dev \
  make \
  nodejs \
  nodejs-legacy \
  npm \
  patch \
  pkg-config \
  sqlite3 \
  vim \
  zlib1g-dev

RUN npm install -g phantomjs
RUN mkdir /my-app
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --without development test

ADD . /my-app
WORKDIR /my-app

RUN rm -rf shared
RUN mkdir -p shared/logs shared/pids shared/sockets
RUN chown -R 777 shared/

RUN bundle exec rake assets:precompile
CMD bundle exec puma -p 3000 -C ./config/puma.rb

EXPOSE 3000
