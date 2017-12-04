FROM ruby:2.3.1

MAINTAINER Mithil Manjrekar (mithil.manjrekar@cuelogic.com)

RUN apt-get update && apt-get install -y nodejs sqlite3 vim --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV development
ENV RAILS_LOG_TO_STDOUT true
ENV ACCESS_KEY "test"
ENV SECRET_KEY "test"
ENV BUCKET_NAME "test"
ENV RAILS_VERSION 5.0.0

RUN gem install rails --version "$RAILS_VERSION"

COPY . ./
WORKDIR .

RUN gem install bundler && bundle install 

EXPOSE 3000
CMD ["rails", "s", "-b", "127.0.0.1"]
