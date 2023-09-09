FROM ubuntu:22.04

# stops the install of tzdata asking for stuff
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Setup the test user account
RUN apt-get update \
 && apt-get install -y sudo vim git-all bash
run echo "testuser ALL=(ALL) NOPASSWD:ALL" | tee -a /etc/sudoers
RUN adduser testuser --disabled-password --gecos ''
RUN usermod -aG sudo testuser

USER testuser
RUN rm /home/testuser/.bashrc
RUN rm /home/testuser/.profile
WORKDIR /home/testuser/dotfiles

ENTRYPOINT ["bash", "./install.sh"]
