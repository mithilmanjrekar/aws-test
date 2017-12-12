#!/bin/sh

apt-get -y update

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get -y update

apt-cache policy docker-ce

apt-get install -y docker-ce

docker ps

# echo "Create a docker postgres image .........."

# docker build -t postgres_image .

# echo "Run the docker postgres image .........."

# docker run --rm -P --name postgres postgres_image

# echo "Docker building the rails app form the Dockerfile .........."

# docker build -t rails-app .

# echo "Docker running the rails app container created form the Dockerfile .........."

# docker run  --rm -d --name rails-connect-to-potgres --link postgres:postgres -p 3000:3000 rails-app

# echo "Docker running the migrations on postgres .........."

# docker exec rails-connect-to-potgres bundle exec rake db:create
# docker exec rails-connect-to-potgres bundle exec rake db:migrate

# echo "Running the docker test cases .........."

# docker exec rails-connect-to-potgres rspec spec/models/user_spec.rb 

# echo "Docker ends testing here .........."