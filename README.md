# bioresolver-docker

A dockerfile for pulling the latest Bioresolver service and running its web app. Run with:

1. Make an `.env` file with `PYOBO_SQLALCHEMY_URI`. If you're on mac and trying to connect to 
   `localhost`, use `host.docker.internal` instead ([ref](https://stackoverflow.com/questions/30239152/specify-extras-require-with-pip-install-e)).
2. Run the following code:

    ```shell
    git clone https://github.com/bionames/bioresolver-docker.git
    cd bioresolver-docker
    docker-compose up
    ```
