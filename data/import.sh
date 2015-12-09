#!/bin/sh

mongoimport --db garden --collection orders --drop --file garden.orders.json
mongoimport --db garden --collection products --drop --file garden.products.json
mongoimport --db garden --collection categories --drop --file garden.categories.json
mongoimport --db garden --collection reviews --drop --file garden.reviews.json
mongoimport --db garden --collection users --drop --file garden.users.json
mongoimport --db examples --collection restaurants --drop --file retaurants.json
mongoimport --db examples --collection books --drop --file books.json

wget http://s3.amazonaws.com/MongoDBInAction/stocks.zip
if [ -f stocks.zip ]; then
  unzip stocks.zip
  if [ -d dump ]; then
    mongorestore --drop -d stocks dump/stocks
    rm -rf dump
  fi
  rm -f stocks.zip
fi
