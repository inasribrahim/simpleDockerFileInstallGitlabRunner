FROM ubuntu
MAINTAINER  ibrahim Nasr "ibrahim.nasribrahim@gitlab.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y 
RUN apt-get upgrade -y 
RUN	apt-get -y install vim 
RUN	apt-get -y install git  
RUN	apt-get -y install curl


CMD ["echo","start using docker"]

#Change Directory to home
RUN cd home

RUN mkdir gitlab-runner
RUN cd gitlab-runner

RUN curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permissions to execute
RUN chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab CI user
RUN useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as service
RUN gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
RUN gitlab-runner register --url https://gitlab.com/ --registration-token $REGISTRATION_TOKEN