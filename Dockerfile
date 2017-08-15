FROM bitwalker/alpine-elixir:latest
MAINTAINER Paul Schoenfelder <paulschoenfelder@gmail.com>
ENV REFRESHED_AT=2017-07-26 \
    TERM=xterm
RUN \
    mkdir -p /opt/app && \
    chmod -R 777 /opt/app && \
    apk update && \
    apk --no-cache --update add \
      git make g++ wget curl inotify-tools \
      nodejs nodejs-current-npm && \
    npm install npm -g --no-progress && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

ENV PATH=./node_modules/.bin:$PATH \
    HOME=/opt/app

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir -p /app
ARG VERSION=1.0.0
COPY . /app
WORKDIR /app
RUN mix deps.get
RUN mix event_store.create
RUN mix do ecto.create, ecto.migrate
RUN tar xvzf log_app.tar.gz
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PORT 8080
CMD ["mix phx.server"]
