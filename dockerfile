# # bring in the micromamba image so we can copy files from it
# FROM mambaorg/micromamba:latest as micromamba

FROM linuxserver/code-server:latest

# Install base utilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential  && \
    apt-get install -y wget && \
    apt-get install -y htop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure SSH
COPY id_rsa /config/.ssh/

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# # Install mamba
# WORKDIR /app
# RUN apt-get update && apt-get install -y wget bzip2 \
#     && wget -qO-  https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba \
#     && touch /root/.bashrc \
#     && ./bin/micromamba shell init -s bash -p /opt/conda  \
#     && grep -v '[ -z "\$PS1" ] && return' /root/.bashrc  > /opt/conda/bashrc   # this line has been modified \
#     && apt-get clean autoremove --yes \
#     && rm -rf /var/lib/{apt,dpkg,cache,log}

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH
ENV SUDO_PASSWORD=1234

RUN conda install mamba -n base -c conda-forge