#!/bin/bash

# Clone the GitHub repo
git clone https://github.com/M-S-Dhanushkumar/my_web_app.git

# Build the Docker image
docker build -t dhanushkumar28/my_web_app:latest .

# Authenticate to Docker Hub (you'll be prompted for your Docker Hub credentials)
docker login

# Push the Docker image to Docker Hub
docker push dhanushkumar28/my_web_app:latest

docker stop my_web_app_container 

docker container rm my_web_app_container

# Run the Docker container
docker run -d -p 80:80 --name my_web_app_container dhanushkumar28/my_web_app:latest
