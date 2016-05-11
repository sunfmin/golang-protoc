FROM golang:alpine

ENV PROTOC_VERSION=3.0.0-beta-2

RUN apk update && \
  apk add build-base curl autoconf automake libtool file zlib-dev git

ADD https://github.com/google/protobuf/releases/download/v"$PROTOC_VERSION"/protobuf-cpp-"$PROTOC_VERSION".tar.gz protobuf.tgz

RUN zcat protobuf.tgz | tar xvf - && \
  cd protobuf-3.0.0-beta-2 && \
  ./configure --prefix=/usr && \
  make -j 4 && \
  make check && \
  make install && \
  make clean

RUN go get -u github.com/golang/protobuf/protoc-gen-go && go get google.golang.org/grpc

ENTRYPOINT ["protoc"]