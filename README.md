# node8build

A node 8 build container for docker, with support for ssh keys

Copy keys to this secured path

    /usr/keys

Copy to this path to build

    /usr/build

## Build

Build

    docker build -t shukriadams/node8build .

Test

    docker run --name mytest -dit shukriadams/node8build:latest  
    docker exec mytest node -v

Login in to docker. Push to docker hub

    docker tag shukriadams/node8build:x.y.z
    docker push shukriadams/node8build:x.y.z
    docker push shukriadams/node8build:latest

## Use

This script is inteded to be used directly in Jenkins build jobs. Example build :

    # remove existing container, start a new instance
    container=myBuildContainer
    docker stop $container || true && docker rm $container || true
    docker run --name $container -dit shukriadams/node8build:latest 

    # copy required ssh keys to /usr/keys folder
    docker cp /host/key/path/id_rsa $container:/usr/keys

    # copy source code to build folder
    docker cp /src/code/. $container:/usr/build

    # build
    docker exec $container /bin/bash -c "npm install -g grunt && npm install && grunt assemble"

    # copy build artefacts out
    docker cp $container:/usr/build/. /host/build/artefacts/path

