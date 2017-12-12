#!/bin/sh
# https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository

#!/bin/bash
set -e

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ $UID -eq 0 ]; then
  echo "Error: running as root, run as a regular user."
  exit 1
fi

KERNEL_VERSION=$(uname -r | awk -F. '{printf("%d%03d", $1, $2)}')
if [ $KERNEL_VERSION -lt 3008 ]; then
    echo "Warning: You are using a kernel older than 3.8!!"
    echo "         for docker to function properly, you should have kernel 3.8 or higher"
    echo "         the building process may fail."
    echo
    echo "         press Ctrl-C to abort, press enter to continue..."
    read
fi

if ! hash docker >/dev/null; then
    echo "Error: docker not found. Please install it first."
    echo
    echo "   instructions at https://docs.docker.com/installation/"
    echo
    exit 1
fi

if ! id | grep docker >/dev/null; then
    echo "Error: $USER is not in the docker group." 
    echo
    echo " To add yourself to a docker group:"
    echo
    echo "   sudo usermod -a -G docker $USER"
    echo
    echo " you must logout for the changes to take effect."
    exit 1
fi

if [ ! -f "resources/image-name" ]; then
    echo "Error: unable to find resource folder."
    exit 1
fi

IMAGE=$(cat resources/image-name)

ati_version=$(dmesg | awk '/fglrx.*module/ { print $8  }')

if [ -z $ati_version ]; then
    echo "Must be run on linux with ati hardware!"
    [ -n "$NO_ABORT" ] || exit 1
fi

current_ati_packages=$(dpkg -l | awk '/fglrx/ {print $2}')

if [ -z "$current_ati_packages" ]; then
    echo "Must have installed the fglrx-* ati packages locally."
    [ -n "$NO_ABORT" ] || exit 1
fi

if [ -z "$(ls -A resources/ati/*.deb 2>/dev/null)"  ]; then
    apt-get -d --reinstall install $current_ati_packages
    mkdir -p resources/ati
    cp /var/cache/apt/archives/fglrx* resources/ati
fi

if [ ! -f resources/video-driver-install ]; then
    mkdir -p /tmp/deb-build
    echo touch /tmp/do_not_build_dkms_module > resources/video-driver-install
    for deb in resources/ati/*.deb; do
        rm -f /tmp/deb-build/*
        dpkg-deb -e $deb /tmp/deb-build
        echo dpkg-deb -x /tmp/ati/$(basename $deb) / >> resources/video-driver-install
        if [ -f /tmp/deb-build/postinst ]; then
            cp /tmp/deb-build/postinst resources/ati/$(basename $deb .deb).postinst
            echo bash /tmp/ati/$(basename $deb .deb).postinst configure >> resources/video-driver-install
        fi
    done
    chmod 755 resources/video-driver-install
fi

echo "building $IMAGE image ..."
sudo docker build --rm=true -t $IMAGE $* .

echo $0 done


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