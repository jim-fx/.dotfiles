FROM debian:latest

ADD . /root/.dotfiles

RUN apt-get update && apt-get upgrade -y
RUN apt-get install curl git zsh -y

ENTRYPOINT ~/.dotfiles/setup.sh
