# För att kunna uppdatera spiik.com samt nollning.spiik.com
# Ubuntu, Ruby, LocomotiveCMS, Wagon
# https://github.com/bobinush/spiik-web

FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Stockholm
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]
# Install any needed packages
RUN apt-get update -qq && apt-get -qqy install ruby-full \
    curl git-core zlib1g-dev build-essential libssl-dev \
    libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
    libxml2-dev libxslt1-dev libcurl4-openssl-dev \
    software-properties-common libffi-dev yarn tzdata

# Install LocomotiveCMS and Wagon
RUN gem install locomotivecms_wagon bundler -q

# Fix timezone, otherwise Wagon wont clone the website..
RUN dpkg-reconfigure -f noninteractive tzdata

# Set the working directory to /spiik and marks it as holding externally mounted volumes 
RUN mkdir /spiik
VOLUME /spiik
WORKDIR /spiik
EXPOSE 3333

# Bugfix "#<Errno::EADDRNOTAVAIL: Failed to open TCP connection to localhost:35729..."
# https://github.com/locomotivecms/wagon/issues/340
# You need to run these 3 commands to get it to work:
# cp /etc/hosts /etc/hosts.new
# sed -i 's/::1\tlocalhost ip6-localhost ip6-loopback/::1 ip6-localhost ip6-loopback/' /etc/hosts.new
# cp -f /etc/hosts.new /etc/hosts
