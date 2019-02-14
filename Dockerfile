FROM ubuntu:16.04
RUN apt update -y && apt install -y gnat
COPY GAda/ /Sources
