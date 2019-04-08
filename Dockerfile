FROM icepack/firedrake:buster

RUN sudo apt-get update
RUN pip3 install --upgrade pip

RUN sudo apt-get -yq install npm nodejs

RUN pip3 install jupyterhub
RUN sudo npm install -g configurable-http-proxy
RUN pip3 install notebook
