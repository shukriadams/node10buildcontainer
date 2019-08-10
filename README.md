# node10buildContainer

A node 10 build container for docker, with support for ssh keys, webpack, jspm and expreact workflows.

Copy keys to this secured path

    /usr/keys

Copy to this path to build

    /usr/build

## Build

To build, run the following at the command line in project root

    docker build -t shukriadams/node10build .

Test

    docker run --name mytest -dit shukriadams/node10build:latest  
    docker exec mytest node -v   # > v10.16.0  
    docker exec mytest yarn -v   # > 1.17.3

Login in to docker. Push to docker hub

    docker tag shukriadams/node10build:latest shukriadams/node10build:x.y.z
    docker push shukriadams/node10build:x.y.z
    docker push shukriadams/node10build:latest

## Use

This script is inteded to be used directly in Jenkins build jobs. Example build :

    # remove existing container, start a new instance
    container=myBuildContainer
    docker stop $container || true && docker rm $container || true
    docker run --name $container -dit shukriadams/node10build:latest 

    # copy required ssh keys to /usr/keys folder
    docker cp /host/key/path/id_rsa $container:/usr/keys

    # copy source code to build folder
    docker cp /src/code/. $container:/usr/build

    # build
    docker exec $container /bin/bash -c "npm install -g grunt && npm install && grunt assemble"

    # copy build artefacts out
    docker cp $container:/usr/build/. /host/build/artefacts/path

