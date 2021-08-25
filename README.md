# biolookup-docker

This repository uses Docker to containerize the Biolookup Service web application, built on top
of [PyOBO](https://github.com/pyobo/pyobo). A public instance maintained by
the [INDRA Lab](https://indralab.github.io) is served at http://biolookup.io.

## Building Database

```shell
$ pyobo database build
$ pyobo database sql load
```

If `--uri` is not given for the load command, it uses `pystow.get_config("pyobo","sqlalchemy_uri)`
to look up from `PYOBO_SQLALCHEMY_URI` or in `~/.config/pyobo.ini`If none is given, a default SQLite
database will be created in `~/.data/pyobo/pyobo.db`.

## Running

### 🌐 Running Locally from Source

A dockerfile for pulling the latest Biolookup service and running its web app. Run with:

1. Make an `.env` file with `PYOBO_SQLALCHEMY_URI`. If you're on Mac and trying to connect to
   `localhost`, use `host.docker.internal`
   instead ([ref](https://stackoverflow.com/questions/30239152/specify-extras-require-with-pip-install-e))
   .
2. Run the following code:

    ```shell
    $ git clone https://github.com/biolookup/biolookup-docker.git
    $ cd biolookup-docker
    $ docker-compose up
    ```

### 🏗️ Building and Running Locally from Docker

After cloning, the image can be built locally with:

```shell
$ docker build -t biolookup:latest .
$ docker run --name biolookup -d -p 8765:8765 --env-file biolookup.env biolookup:latest
```

Where `-d` means "detached" mode.
You'll need an environment file the same as described above. Alternatively, environment variables
can be passed with `--env` (or `-e` for short) like in:

```shell
$ docker build -t biolookup:latest .
$ docker run --name biolookup -d -p 8765:8765 --env PYOBO_SQLALCHEMY_URI=foo biolookup:latest
```

### 🐋 Running Locally from Docker

The image is hosted on Docker Hub under `cthoyt/biolookup:latest` and can be run with:

```shell
$ docker run -id --name biolookup -p 8765:8765 --env-file biolookup.env cthoyt/biolookup:latest
```

The default port run by the app is `8765`, but the `-p` option lets you map it to another port.
You'll need an environment file the same as described above. Alternatively, environment variables
can be passed with `--env` (or `-e` for short) like in:

```shell
$ docker run -id --name biolookup -p 8765:8765 --env PYOBO_SQLALCHEMY_URI=foo cthoyt/biolookup:latest
```

## 🕵️ Logging

The logs can be shown with

```shell
$ BIOLOOKUP_CONTAINER_ID=$(docker ps --filter "name=biolookup" -q)
$ docker exec $BIOLOOKUP_CONTAINER_ID /usr/bin/tail -f /root/.data/pyobo/biolookup/log.txt
```

## 📡 Pushing to Docker Hub

This repository is set up with
a [GitHub Action](https://github.com/biolookup/biolookup-docker/actions/workflows/ci.yml)
to build the dockerfile and push
to [Docker Hub](https://hub.docker.com/repository/docker/cthoyt/biolookup).

## 🎁 Support

The Biolookup Service was developed by the [INDRA Lab](https://indralab.github.io), a part of the
[Laboratory of Systems Pharmacology](https://hits.harvard.edu/the-program/laboratory-of-systems-pharmacology/about/)
and the [Harvard Program in Therapeutic Science (HiTS)](https://hits.harvard.edu)
at [Harvard Medical School](https://hms.harvard.edu/).

## 💰 Funding

The development of the Biolookup Service is funded by the DARPA Automating Scientific Knowledge
Extraction (ASKE) program under award HR00111990009.
