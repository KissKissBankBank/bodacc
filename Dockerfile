FROM ruby:2.3

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' > \
    /etc/apt/sources.list.d/postgres.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    apt-key add - && \
    apt-get update -qqy && \
    apt-get upgrade -qqy && \
    apt-get install -y postgresql-client-9.6 nginx \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]
