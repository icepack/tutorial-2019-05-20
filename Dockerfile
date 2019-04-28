FROM jupyter/scipy-notebook

MAINTAINER Daniel Shapero <shapero@uw.edu>

USER root
RUN apt-get update && apt-get -yq install \
    autoconf \
    automake \
    build-essential \
    cmake \
    curl \
    gfortran \
    git \
    libblas-dev \
    libboost-dev \
    liblapack-dev \
    libopenmpi-dev \
    libtool \
    neovim \
    openmpi-bin \
    openssh-client \
    python3-dev \
    python3-pip \
    python3-tk \
    python3-venv \
    zlib1g-dev

# As the default session user, create a firedrake environment based on the
# default jupyterhub/scipy environment, but without HDF5 -- firedrake needs its
# own specific version of HDF5.
USER jovyan
RUN pip install mpltools
RUN conda list --explicit | grep -v hdf5 | grep -v h5py | grep -v asn1crypto > spec-file.txt
RUN conda create -n firedrake --file spec-file.txt
RUN rm spec-file.txt

# Install firedrake
WORKDIR /opt/conda/envs/firedrake/
RUN curl -O https://raw.githubusercontent.com/firedrakeproject/firedrake/master/scripts/firedrake-install
RUN bash -c "source activate firedrake && python3 firedrake-install --no-package-manager --disable-ssh --venv-name=firedrake-venv"

# Set up a bash environment for interactive shell use
RUN mkdir -p /opt/conda/envs/firedrake/etc/conda/activate.d
RUN echo export VIRTUAL_ENV_DISABLE_PROMPT=1 > /opt/conda/envs/firedrake/etc/conda/activate.d/00_virtual_env_disable_prompt.sh
RUN cp /opt/conda/envs/firedrake/firedrake-venv/bin/activate /opt/conda/envs/firedrake/etc/conda/activate.d/01_firedrake-venv.sh
RUN mkdir -p /opt/conda/envs/firedrake/etc/conda/deactivate.d
RUN echo deactivate > /opt/conda/envs/firedrake/etc/conda/deactivate.d/01_firedrake-venv.sh
RUN echo "export PATH=$(echo $PATH | sed 's@/opt/conda/envs/firedrake/firedrake-venv/bin:@@')" >> /opt/conda/envs/firedrake/bin/deactivate

# Install an iPython kernel for firedrake
RUN bash -c "source activate firedrake && pip install jupyterhub ipykernel"
USER root
RUN mkdir -p /usr/local/share/jupyter
RUN chown jovyan /usr/local/share/jupyter
USER jovyan
RUN bash -c "source activate firedrake && python -m ipykernel install --name firedrake --display-name 'Python 3 (firedrake)'"

# Complete the environment, and leave the container in a state ready for jhub
RUN bash -c "source activate firedrake && pip install mpltools nbformat"
WORKDIR /home/jovyan
#RUN bash -c "source activate firedrake && move-notebooks"
#RUN bash -c "source activate firedrake && rekernel-notebooks"
RUN rmdir work
ENV OMPI_MCA_btl=tcp,self
