To build the docker image:

    docker build -t icepack/tutorial:latest

To run the docker image and expose a port so we can talk to JupyterHub:

    docker run --interactive --tty --publish 8000:8000 icepack/tutorial:latest
