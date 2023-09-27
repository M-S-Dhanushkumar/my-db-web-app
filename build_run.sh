#!/bin/bash

# Clone the GitHub repo
#git clone https://github.com/M-S-Dhanushkumar/my_web_app.git

cd /home/dhanush/my_web_app/my_web_app

VERSION=$(git log -1 --pretty=%h)
REPO="dhanushkumar28/my_web_app:"
TAG="$REPO$VERSION"
LATEST="${REPO}latest"
BUILD_TIMESTAMP=$( date '+%F_%H:%M:%S' )

echo "Time: $BUILD_TIMESTAMP"
pwd

REMOTE=origin
BRANCH=main
git fetch
if [[ "$(git rev-parse $BRANCH)" != "$(git rev-parse "$REMOTE/$BRANCH")" ]]; then
echo "Found Changes"

# Run your script
git pull 
# Build the Docker image
docker build -t "$TAG" -t "$LATEST" --build-arg VERSION="$VERSION" --build-arg BUILD_TIMESTAMP="$BUILD_TIMESTAMP" . 

# Authenticate to Docker Hub (you'll be prompted for your Docker Hub credentials)
docker login

# Push the Docker image to Docker Hub
#docker push dhanushkumar28/my_web_app:latest
docker push "$TAG"
docker push "$LATEST"

docker stop my_web_app_container 

docker container rm my_web_app_container

# Run the Docker container
docker run -d -p 80:80 --name my_web_app_container dhanushkumar28/my_web_app:"$VERSION"
else
	echo "No change on $REMOTE/$BRANCH"
fi
