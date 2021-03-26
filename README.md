# bioresolver-docker

This repository uses Docker to containerize the Bioresolver web application, built on 
top of [PyOBO](https://github.com/pyobo/pyobo).

## Running Locally

A dockerfile for pulling the latest Bioresolver service and running its web app. Run with:

1. Make an `.env` file with `PYOBO_SQLALCHEMY_URI`. If you're on mac and trying to connect to 
   `localhost`, use `host.docker.internal` instead ([ref](https://stackoverflow.com/questions/30239152/specify-extras-require-with-pip-install-e)).
2. Run the following code:

    ```shell
    $ git clone https://github.com/bionames/bioresolver-docker.git
    $ cd bioresolver-docker
    $ docker-compose up
    ```
  
## Running from Docker

The image is hosted on Docker Hub under `cthoyt/bioresolver:latest` and can be run with

```shell
$ docker run -id -p 8765:8765 --env-file bioresolver.env cthoyt/bionames:latest
```
 
The default port run by the app is `8765`, but the `-p` option lets you map it to another port.
You'll need an environment file the same as described above. Alternatively, environment variables
can be passed with `--env` (or `-e` for short) like in:

```shell
$ docker run -id -p 8765:8765 --env PYOBO_SQLALCHEMY_URI=foo cthoyt/bionames:latest
```

## Push

This repository is set up with a [GitHub Action](https://github.com/bionames/bioresolver-docker/actions/workflows/ci.yml)
to build the dockerfile and push to [Docker Hub](https://hub.docker.com/repository/docker/cthoyt/bioresolver).
