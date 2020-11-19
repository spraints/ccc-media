FROM ruby:2.6.6

WORKDIR /app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor/cache vendor/cache
RUN bundle install
RUN bundle package
COPY . .
