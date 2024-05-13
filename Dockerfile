FROM ubuntu:20.04

MAINTAINER Geoff Twardokus

RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y build-essential gcc g++ bison flex perl tcl-dev tk-dev blt libxml2-dev zlib1g-dev default-jre doxygen graphviz openmpi-bin libopenmpi-dev libpcap-dev autoconf automake libtool libproj-dev libfox-1.6-dev libgdal-dev libxerces-c-dev

WORKDIR /root

RUN apt install -y software-properties-common
RUN apt -y install cmake python g++ libxerces-c-dev libfox-1.6-dev libgdal-dev libproj-dev libgl2ps-dev swig
RUN apt -y install wget
RUN wget https://sourceforge.net/projects/sumo/files/sumo/version%201.8.0/sumo-src-1.8.0.tar.gz/download -O sumo
RUN tar -xf sumo
RUN cd sumo-1.8.0
export SUMO_HOME=$(pwd)
RUN mkdir build/cmake-build && cd build/cmake-build
RUN cmake ../.. && make


#RUN apt install -y 

#ARG sumoDirName=sumo-all-1.8.0

#RUN apt install -y wget
#RUN wget https://sourceforge.net/projects/sumo/files/sumo/version%201.8.0/sumo-all-1.8.0.tar.gz/download -O ${sumoDirName}.tar.gz

#COPY ./${sumoDirName}.tar /root/

#RUN tar -xf ${sumoDirName}.tar
#RUN export SUMO_HOME="/root/${sumoDirName}"
