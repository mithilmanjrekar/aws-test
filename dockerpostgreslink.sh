#!/bin/sh

sudo apt-get -y update

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get -y update

apt-cache policy docker-engine

sudo apt-get -y install -y docker-engine

sudo systemctl status docker

docker ps

echo "Create a docker postgres image .........."

docker build -t postgres_image .

echo "Run the docker postgres image .........."

docker run --rm -P --name postgres postgres_image

echo "Docker building the rails app form the Dockerfile .........."

docker build -t rails-app .

echo "Docker running the rails app container created form the Dockerfile .........."

docker run  --rm -d --name rails-connect-to-potgres --link postgres:postgres -p 3000:3000 rails-app

echo "Docker running the migrations on postgres .........."

docker exec rails-connect-to-potgres bundle exec rake db:create
docker exec rails-connect-to-potgres bundle exec rake db:migrate

echo "Running the docker test cases .........."

docker exec rails-connect-to-potgres rspec spec/models/user_spec.rb 

echo "Docker ends testing here .........."