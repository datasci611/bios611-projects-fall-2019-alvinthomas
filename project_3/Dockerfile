FROM gcc
MAINTAINER alvin@unc.edu

RUN git clone https://github.com/lindenb/makefile2graph.git &&\
  cd makefile2graph &&\
  make
RUN apt-get update && apt-get install -y graphviz
