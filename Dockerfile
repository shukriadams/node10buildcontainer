# note, we have to build as root user because the build process will very likely require us to install
# packages as root to this container

FROM alpine:3.7

RUN apk update &&\
    apk upgrade &&\
    apk add git &&\
    apk add bash &&\
    apk add sshpass=1.06-r0 &&\
    apk add curl ca-certificates openssh &&\
    apk add nodejs=8.9.3-r1 &&\
    npm install yarn -g &&\
    npm install webpack -g &&\
    npm install webpack-cli -g &&\
    mkdir -p /usr/keys &&\
    mkdir -p /usr/build 

WORKDIR /usr/build

# fix key permissions, then keep container up indefinitely
CMD ["/bin/sh", "-c", "chmod 700 -R /usr/keys && while true ;sleep 5; do continue; done"]