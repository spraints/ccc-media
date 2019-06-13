ARG RUBY_VERSION=latest
FROM ruby:$RUBY_VERSION

RUN gem install --version 1.17.3 bundler

COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get -y install nodejs

ARG UID=1000
RUN useradd --create-home --uid $UID devuser
RUN echo PATH=/usr/local/bundle/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games >> /home/devuser/.profile

RUN chmod -R a+w,a+r /usr/local/bundle

USER devuser
