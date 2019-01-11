FROM archlinux/base
MAINTAINER Max Gonzih <gonzih at gmail dot com>

ENV HUGO_VER 0.53

RUN pacman -Suy git make hugo --noconfirm \
    && hugo version

VOLUME /var/website

EXPOSE 1313

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV USER gnzh

ARG GNZHUID

RUN useradd -m -u $GNZHUID $USER

USER $USER
RUN mkdir $HOME/bin
ENV HOME /home/$USER/

WORKDIR /var/website
