FROM sameersbn/gitlab-ci-runner:latest
MAINTAINER bustta80980@gmail.com

RUN apt-get update && \
    apt-get install -y build-essential cmake openssh-server \
      ruby2.1-dev libmysqlclient-dev zlib1g-dev libyaml-dev libssl-dev \
      libgdbm-dev libreadline-dev libncurses5-dev libffi-dev \
      libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev \
      fontconfig && \
    gem install --no-document bundler && \
    rm -rf /var/lib/apt/lists/* # 20150504

RUN apt-get install -y curl

# nvm
RUN wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
RUN echo '. /.nvm/nvm.sh' >> /root/.bashrc

RUN cat /root/.bashrc /.nvm/nvm.sh
RUN bash -c '. /.nvm/nvm.sh ; nvm install 0.8'
RUN bash -c '. /.nvm/nvm.sh ; nvm install 0.10'
RUN bash -c '. /.nvm/nvm.sh ; nvm install 0.11'
RUN bash -c '. /.nvm/nvm.sh ; nvm alias default 0.10'

ADD assets/ /app/
RUN chmod 755 /app/setup/install
RUN /app/setup/install