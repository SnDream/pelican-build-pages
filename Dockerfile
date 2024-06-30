FROM python:3.10.12-slim

RUN apt-get update \
  && apt-get install -y \
    git \
    locales \
    nodejs

RUN \
  echo "en_US UTF-8" > /etc/locale.gen && \
  locale-gen en-US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

