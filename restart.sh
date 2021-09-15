#!/bin/bash

# Store the container's hash
BIOLOOKUP_CONTAINER_ID=$(docker ps --filter "name=biolookup" -aq)

# Stop and remove the old container, taking advantage of the fact that it's named specifically
if [ -n "BIOLOOKUP_CONTAINER_ID" ]; then
  docker stop BIOLOOKUP_CONTAINER_ID
  docker rm BIOLOOKUP_CONTAINER_ID
fi

# Pull the latest
docker pull biopragmatics/biolookup:latest

# Run the start script
docker run -id --name biolookup -p 8766:8766 biopragmatics/biolookup:latest
