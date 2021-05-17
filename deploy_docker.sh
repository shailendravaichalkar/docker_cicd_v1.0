#!/bin/sh
########################################
# Put this on a Server
# run chmod +x deploy_app.sh to make the script executable
# 
# Execute this script:  ./deploy_app.sh ariv3ra/python-circleci-docker:$TAG
# Replace the $TAG with the actual Build Tag you want to deploy
#
########################################

set -e

DOCKER_IMAGE=$1
CONTAINER_NAME="html-docker-demo-poc"
CERT_PORT="8081:80"
PROD_PORT="8082:80"


# Check for arguments
if [[ $# -lt 1 ]] ; then
    echo '[ERROR] You must supply a Docker Image to pull'
    exit 1
fi

cd "/home/devops/docker_cicd"

echo "Deploying $CONTAINER_NAME to Docker Container"

#Check for running container & stop it before starting a new one
if [ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}_CERT) = "true" ]; then
    docker stop ${CONTAINER_NAME}_CERT
fi

#Check for running container & stop it before starting a new one
if [ $(docker inspect -f '{{.State.Running}}' ${CONTAINER_NAME}_PROD) = "true" ]; then
    docker stop ${CONTAINER_NAME}_PROD
fi

echo "Starting $CONTAINER_NAME using Docker Image name: $DOCKER_IMAGE for CERT"

#CERT
docker run -d --rm=true -p $CERT_PORT  --name ${CONTAINER_NAME}_CERT $DOCKER_IMAGE

echo "Starting $CONTAINER_NAME using Docker Image name: $DOCKER_IMAGE for PROD"

#PROD
docker run -d --rm=true -p $PROD_PORT  --name ${CONTAINER_NAME}_PROD $DOCKER_IMAGE

docker ps -a
