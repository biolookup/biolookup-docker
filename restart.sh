#!/bin/bash

# store the biolookup id
BIOLOOKUP_CONTAINER_ID=$(docker ps --filter "name=biolookup" -q)

# Stop and remove the old container taking advantage
#  of the fact that it's named specifically
docker stop $BIOLOOKUP_CONTAINER_ID
docker rm $BIOLOOKUP_CONTAINER_ID

# Pull the latest
docker pull biopragmatics/biolookup:latest

# Run the start script
docker run -id --name biolookup -p 8766:8766 biopragmatics/biolookup:latest
