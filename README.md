# biolookup-docker

This repository uses Docker to containerize the Biolookup Service web application, built on top
of [PyOBO](https://github.com/pyobo/pyobo). A public instance maintained by
the [INDRA Lab](https://indralab.github.io) is served at http://biolookup.io.

## Running the Biolookup Service

Before running the Biolookup Service, you'll need to prepare either a local database or get a
connection string to a remote database.
See [here](https://github.com/biopragmatics/biolookup#%EF%B8%8F-load-the-database)
for instructions on loading the database.

### 🌐 Running Locally from Source

A dockerfile for pulling the latest Biolookup service and running its web app. Run with:

1. Make an `.env` file with `BIOLOOKUP_SQLALCHEMY_URI`. If you're on Mac and trying to connect to
   `localhost`, use `host.docker.internal`
   instead ([ref](https://stackoverflow.com/questions/30239152/specify-extras-require-with-pip-install-e))
   .
2. Run the following code:

    ```shell
    $ git clone https://github.com/biopragmatics/biolookup-docker.git
    $ cd biolookup-docker
    $ docker-compose up
    ```
  
    In case you're using a non-standard named `docker-compose.yml`, you can pass the `-f` flag
    to give the name of the file like in `docker-compose -f biolookup-compose.yml up --detach`.

### 🏗️ Building and Running Locally from Docker

After cloning, the image can be built locally with:

```shell
$ docker build -t biolookup:latest .
$ docker run --name biolookup -d -p 8765:8765 --env-file biolookup.env biolookup:latest
```

Where `-d` means "detached" mode. You'll need an environment file the same as described above.
Alternatively, environment variables can be passed with `--env` (or `-e` for short) like in:

```shell
$ docker build -t biolookup:latest .
$ docker run --name biolookup -d -p 8765:8765 --env BIOLOOKUP_SQLALCHEMY_URI=foo biolookup:latest
```

### 🐋 Running Locally from Docker

The image is hosted on Docker Hub
under [`biopragmatics/biolookup:latest`](https://hub.docker.com/r/biopragmatics/biolookup) and can
be run with:

```shell
$ docker run -id --name biolookup -p 8765:8765 --env-file biolookup.env biopragmatics/biolookup:latest
```

The default port run by the app is `8765`, but the `-p` option lets you map it to another port.
You'll need an environment file the same as described above. Alternatively, environment variables
can be passed with `--env` (or `-e` for short) like in:

```shell
$ docker run -id --name biolookup -p 8765:8765 --env BIOLOOKUP_SQLALCHEMY_URI=foo biopragmatics/biolookup:latest
```

## 🕵️ Logging

The logs can be shown with

```shell
$ docker exec $(docker ps --filter "name=biolookup" -q) /usr/bin/tail -f /root/.data/pyobo/biolookup/log.txt
```

## 📡 Pushing to Docker Hub

This repository is set up with
a [GitHub Action](https://github.com/biopragmatics/biolookup-docker/actions/workflows/ci.yml)
to build the dockerfile and push
to [Docker Hub](https://hub.docker.com/repository/docker/biopragmatics/biolookup).

## 🎁 Support

The Biolookup Service was developed by the [INDRA Lab](https://indralab.github.io), a part of the
[Laboratory of Systems Pharmacology](https://hits.harvard.edu/the-program/laboratory-of-systems-pharmacology/about/)
and the [Harvard Program in Therapeutic Science (HiTS)](https://hits.harvard.edu)
at [Harvard Medical School](https://hms.harvard.edu/).

## 💰 Funding

The development of the Biolookup Service is funded by the DARPA Automating Scientific Knowledge
Extraction (ASKE) program under award HR00111990009.
