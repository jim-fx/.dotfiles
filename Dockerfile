FROM debian:latest

ADD . ~/.dotfiles

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install curl git -y

ENTRYPOINT ~/.dotfiles/setup.sh