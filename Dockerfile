FROM ruby:2.3

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . /usr/src/app

ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]
