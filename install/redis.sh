#!/bin/bash
source load_config.sh

echo "-------------------------------------------------------------"
echo "Redis configuration"
echo "-------------------------------------------------------------"
sudo apt-get install -y redis-server

if [ "$install_php" = true ]; then
    echo "-------------------------------------------------------------"
    printf "\n"
    git clone https://github.com/phpredis/phpredis
    cd phpredis
    phpize
    ./configure
    make
    sudo make install
    echo "-------------------------------------------------------------"
    PHP_VER=$(php -v | head -n 1 | cut -d " " -f 2 | cut -f1-2 -d"." )
    # Add redis to php mods available
    printf "extension=redis.so" | sudo tee /etc/php/$PHP_VER/mods-available/redis.ini 1>&2
    sudo phpenmod redis
fi

sudo pip3 install redis

# Disable redis persistance
sudo sed -i "s/^save 900 1/#save 900 1/" /etc/redis/redis.conf
sudo sed -i "s/^save 300 1/#save 300 1/" /etc/redis/redis.conf
sudo sed -i "s/^save 60 1/#save 60 1/" /etc/redis/redis.conf

if [ "$docker" = false ]; then
    sudo systemctl restart redis-server
else
    sudo service redis-server restart
fi
