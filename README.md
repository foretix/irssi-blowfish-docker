# About

This repository is for building a dockerized version of Irssi IRC Client with Blowfish cipher support to encrypt private and public messages in ECB and CBC modes. It also includes and Diffie-Hellman key exchange for private chat.

Blowfish support is integrated using the work of https://github.com/falsovsky/FiSH-irssi

# Install

Download docker image https://cloud.docker.com/u/foretix/repository/docker/foretix/irssi-blowfish-2019

# Run

`docker run -v /yourfolder:/home/user/.irssi irssi-blowfish-2019`
