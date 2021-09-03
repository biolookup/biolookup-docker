#!/bin/bash

echo "Building Biolookup Docker Image"
echo "See https://cthoyt.com/2021/08/28/biolookup-docker.html for more information"

# TODO replace with creation of temporary virtual environment
source ~/.virtualenvs/indra/bin/activate
python -m pip install --upgrade biolookup

export PGPASSWORD="biolookup"
export PORT="5434"
export DATABASE="biolookup"
export NAME="postgres-biolookup"

set -x
set -e

docker login
docker pull postgres

POSTGRES_CONTAINER_ID=$(docker ps --filter "name=$NAME" -aq)
if [ -n "$POSTGRES_CONTAINER_ID" ]; then
  echo "$POSTGRES_CONTAINER_ID is already running, stopping"
  docker stop $POSTGRES_CONTAINER_ID
  docker rm $POSTGRES_CONTAINER_ID
fi

docker run \
  -p "$PORT:5432" \
  --name "postgres-biolookup" \
  --detach \
  -e POSTGRES_PASSWORD=$PGPASSWORD \
  -e PGDATA=/var/lib/postgresql/pgdata \
  --shm-size 1gb postgres

sleep 5
createdb -h localhost -p $PORT -U postgres $DATABASE

biolookup load --uri "postgresql+psycopg2://postgres:$PGPASSWORD@localhost:$PORT/$DATABASE"

docker commit \
    $(docker ps --filter "name=$NAME" -q) \
    biopragmatics/postgres-biolookup:latest
docker push biopragmatics/postgres-biolookup:latest
