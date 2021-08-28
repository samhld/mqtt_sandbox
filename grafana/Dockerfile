# syntax=docker/dockerfile:1

FROM grafana/grafana:latest

USER root

RUN apk update && \
    apk add git && \
    apk add go && \
    apk add yarn

ENV GOBIN="/usr/bin"
ENV GOPATH="/usr/bin"

RUN git clone https://github.com/magefile/mage && \
    cd mage && \
    go run bootstrap.go

WORKDIR /var/lib/grafana/plugins

RUN git clone https://github.com/grafana/mqtt-datasource.git

WORKDIR ./mqtt-datasource

RUN yarn install && \
    yarn build && \
    mage reloadPlugin
