#!/bin/bash

echo "Cleaning up stuff"

docker rm azkaban-development
docker rmi azkaban-development

#ls -1 | grep -v .sh | grep -v Docker | xargs rm -fr

echo "Downloading Azkaban 3.10.0"

curl -o azkaban-3.10.0.zip -LOk https://github.com/azkaban/azkaban/archive/3.10.0.zip
unzip azkaban-3.10.0.zip

echo "Building Azkaban 3.10.0"
cd azkaban-3.10.0
./gradlew distZip
cd ..

echo "Getting dist"
cp azkaban-3.10.0/azkaban-solo-server/build/distributions/azkaban-solo-server-0.1.0-SNAPSHOT.zip .

echo "Unzipping"
unzip azkaban-solo-server-0.1.0-SNAPSHOT.zip

echo "Building docker image"

docker build -t azkaban-development .
docker create  --name azkaban-development azkaban-development
