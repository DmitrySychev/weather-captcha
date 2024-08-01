ARG RUBY_VERSION=3.3.4

FROM ruby:$RUBY_VERSION-bullseye AS base

ENV RAILS_ENV=development

FROM base
ARG BUNDLER_VERSION=2.4.10

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get update -qq && apt-get install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update -qq && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:$BUNDLER_VERSION \
    && gem update --system \
    && gem install tzinfo-data \
    && gem install nokogiri \
    && gem install kamal

RUN echo 'gem: --no-document' >> ~/.gemrc \
    && bundle install

WORKDIR /weather-captcha

COPY . .
