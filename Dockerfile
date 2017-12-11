FROM ruby:2.3.1

MAINTAINER Mithil Manjrekar (mithil.manjrekar@cuelogic.com)

# Sqlite for the rails app to interact until pointed to the rds server 
RUN apt-get update && apt-get install -y nodejs sqlite3 vim --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Environmnet variables
ENV RAILS_ENV development
ENV RAILS_LOG_TO_STDOUT true
ENV ACCESS_KEY ENV[ACCESS_KEY]
ENV SECRET_KEY ENV[SECRET_KEY]
ENV BUCKET_NAME ENV[BUCKET_NAME]
ENV RAILS_VERSION 5.0.0

RUN gem install rails --version "$RAILS_VERSION"

COPY . ./
WORKDIR .


RUN  gem install bundler 
RUN  bundle install 


EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
