FROM ubuntu:20.04

MAINTAINER Geoff Twardokus

RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y build-essential gcc g++ bison flex perl tcl-dev tk-dev blt libxml2-dev zlib1g-dev default-jre doxygen graphviz openmpi-bin libopenmpi-dev libpcap-dev autoconf automake libtool libproj-dev libfox-1.6-dev libgdal-dev libxerces-c-dev

WORKDIR /root

# Install SUMO 1.8.0
RUN apt -y install cmake python g++ libxerces-c-dev libfox-1.6-dev libgdal-dev libproj-dev libgl2ps-dev swig
RUN apt -y install wget
RUN wget https://sourceforge.net/projects/sumo/files/sumo/version%201.8.0/sumo-src-1.8.0.tar.gz/download -O sumo
RUN tar -xf sumo
RUN cd sumo-1.8.0 && mkdir build/cmake-build && cd build/cmake-build && cmake ../.. && make
ENV SUMO_HOME=/root/sumo-1.8.0/bin
ENV PATH="${SUMO_HOME}:${PATH}"
RUN rm -rf sumo

# Install OMNET++ 5.6.2

RUN apt install -y qt5-qmake qtbase5-dev qtbase5-dev-tools libopenscenegraph-dev openscenegraph-plugin-osgearth libosgearth-dev

RUN wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-5.6.2/omnetpp-5.6.2-src-linux.tgz
RUN tar -xf omnetpp-5.6.2-src-linux.tgz
RUN sed -i '2208s/.*/. \/root\/omnetpp-5.6.2\/configure.user/' /root/omnetpp-5.6.2/configure

WORKDIR /root/omnetpp-5.6.2
RUN ./configure
ENV PATH="/root/omnetpp-5.6.2/bin:${PATH}"
RUN make

# Install VEINS 5.2
RUN apt install -y unzip
WORKDIR /root
RUN wget https://veins.car2x.org/download/veins-5.2.zip
RUN unzip veins-5.2.zip

WORKDIR /root/veins-veins-5.2
RUN ./configure
RUN make


# Cleanup
WORKDIR /root
RUN rm omnetpp-5.6.2-src-linux.tgz veins-5.2.zip

# Run test
WORKDIR /root
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]
