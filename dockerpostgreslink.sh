#!/bin/sh
# https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository
sudo /etc/init.d/docker status

sudo groupadd docker

sudo usermod -aG docker $USER

sudo service docker restart

su ${USER}

# apt-get install docker-ee

# apt-cache madison docker-ee

sudo docker run hello-world

sudo docker ps

echo "Create a docker postgres image .........."

sudo docker build -t postgres

echo "Run the docker postgres image .........."

sudo docker run --rm  postgres

echo "Docker building the rails app form the Dockerfile .........."

sudo docker build -t rails-app .

echo "Docker running the rails app container created form the Dockerfile .........."

sudo docker run  --rm -d --name rails-connect-to-potgres --link postgres:postgres -p 3000:3000 rails-app

echo "Docker running the migrations on postgres .........."

sudo docker exec rails-connect-to-potgres bundle exec rake db:create
sudo docker exec rails-connect-to-potgres bundle exec rake db:migrate

echo "Running the docker test cases .........."

sudo docker exec rails-connect-to-potgres rspec spec/models/user_spec.rb 

echo "Docker ends testing here .........."