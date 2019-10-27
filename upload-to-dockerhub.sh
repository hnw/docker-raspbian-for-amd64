#!/bin/bash

set -e

docker login -u=$DOCKERHUB_USER -p=$DOCKERHUB_PASSWORD
docker push $DOCKERHUB_USER/$DOCKERHUB_REPO
