FROM ruby:3.4-alpine3.21 AS builder

RUN apk add --no-cache \
  build-base \
  git

WORKDIR /app

COPY . /app/

RUN gem build site-to-md.gemspec

FROM ruby:3.4-alpine3.21

WORKDIR /app

RUN apk add --no-cache \
  libxml2-dev \
  libxslt-dev

COPY --from=builder /app/site-to-md-*.gem /app/

# Install the gem into a directory included in the PATH
RUN apk add --no-cache --virtual .build-deps build-base \
  && gem install site-to-md-*.gem --install-dir /usr/local/bundle \
  && apk del .build-deps

# Ensure the executables installed by Gem are in the PATH
ENV PATH="/usr/local/bundle/bin:${PATH}"

# Set the entrypoint to the executable
ENTRYPOINT ["site-to-md"]
