FROM golang

ENV PROTOC_VERSION=3.0.0-beta-2

RUN apt-get update && \
	apt-get install -y --no-install-recommends git curl unzip curl dh-autoreconf wamerican

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