FROM roslab/roslab:kinetic-nvidia

USER root

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    libglew-dev \
    libeigen3-dev \
    libopencv-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/stevenlovegrove/Pangolin.git /Pangolin \
 && cd /Pangolin \
 && mkdir build \
 && cd build \
 && cmake ../ \
 && make -j4 install \
 && rm -fr /Pangolin

COPY . ${HOME}

RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}
