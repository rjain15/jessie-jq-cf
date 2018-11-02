FROM golang:alpine
MAINTAINER Rajesh Jain <rjain15@gmail.com>
RUN apk update
RUN apk upgrade

RUN apk --no-cache --virtual add jq bash git

# Install Cloud Foundry cli

ADD https://cli.run.pivotal.io/stable?release=linux64-binary /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && \
  tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && \
  cf --version && \
  rm -f /tmp/cf-cli.tgz

# Install yaml cli
RUN go get gopkg.in/yaml.v2

RUN mkdir -p /opt
WORKDIR /app
CMD /bin/bash
