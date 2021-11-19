# syntax=docker/dockerfile:1

FROM golang:1.16-buster

WORKDIR /go/src

RUN apt-get update && \
    git clone https://github.com/influxdata/telegraf.git

WORKDIR /go/src/telegraf
    
RUN git init && \
    git checkout 66d6f5f295aea42f94004bc22b2c9b6b83d6cc50

RUN make

# CMD ["./cmd/telegraf"]