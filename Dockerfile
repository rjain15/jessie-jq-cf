FROM golang:1.8
MAINTAINER Rajesh Jain <rjain15@gmail.com>
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install jq

# Install Cloud Foundry cli

ADD https://cli.run.pivotal.io/stable?release=linux64-binary /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && \
  tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && \
  cf --version && \
  rm -f /tmp/cf-cli.tgz

# Install cf cli Autopilot plugin

RUN apt-get install ca-certificates && update-ca-certificates && apt-get install openssl
ADD https://github.com/contraband/autopilot/releases/download/0.0.4/autopilot-linux /tmp/autopilot-linux

RUN chmod +x /tmp/autopilot-linux && \
cf install-plugin /tmp/autopilot-linux -f && \
rm -f /tmp/autopilot-linux

# Install yaml cli
ADD https://github.com/mikefarah/yaml/releases/download/1.10/yaml_linux_amd64 /tmp/yaml_linux_amd64
RUN install /tmp/yaml_linux_amd64 /usr/local/bin/yaml && \
  yaml --help && \
  rm -f /tmp/yaml_linux_amd64


RUN mkdir -p /opt
WORKDIR /app
CMD /bin/bash
