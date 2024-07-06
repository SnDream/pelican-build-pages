FROM python:3.10.12-slim

RUN apt-get update \
  && apt-get install -y \
    git \
    locales

RUN \
  printf "en_US.UTF-8 UTF-8\nzh_CN.UTF-8 UTF-8\n" > /etc/locale.gen && \
  locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

