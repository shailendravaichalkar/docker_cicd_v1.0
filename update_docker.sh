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
BUILD_ID=$2

# Check for arguments
if [[ $# -lt 2 ]] ; then
    echo '[ERROR] You must supply a Docker Image Name and tag to build'
    exit 1
fi

cd "/home/devops/docker_cicd"

git pull origin master

docker build -t ${DOCKER_IMAGE}:${BUILD_ID} .

docker tag ${DOCKER_IMAGE}:${BUILD_ID} ${DOCKER_IMAGE}:latest


docker push ${DOCKER_IMAGE}:${BUILD_ID}
docker push ${DOCKER_IMAGE}:latest


