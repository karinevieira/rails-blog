FROM ruby:2.5.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /project
WORKDIR /project
ADD Gemfile /project/Gemfile
ADD Gemfile.lock /project/Gemfile.lock
RUN bundle install
ADD . /project