ARG RUBY_VERSION=3.3.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

ARG DOCKER_USER
ENV DOCKER_USER="$DOCKER_USER"
RUN test -n "$DOCKER_USER" || (echo "DOCKER_USER must be set" && exit 1)

ARG DOCKER_UID
ENV DOCKER_UID="$DOCKER_UID"
RUN test -n "$DOCKER_UID" || (echo "DOCKER_UID must be set" && exit 1)

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="development" BUNDLE_DEPLOYMENT="1" BUNDLE_PATH="/usr/local/bundle"

COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git
COPY . .

RUN groupadd --system --gid $DOCKER_UID $DOCKER_USER && \
    useradd $DOCKER_USER --uid $DOCKER_UID --gid $DOCKER_UID --create-home --shell /bin/bash && \
    chown -R $DOCKER_USER:$DOCKER_USER db log storage tmp
USER $DOCKER_USER:$DOCKER_UID

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
