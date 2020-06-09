FROM golang:1.9 AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN go build -v -o deployment



FROM alpine:3.4
MAINTAINER 	Rich Yourstone <ryourstone@yahoo.com>

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=build /src/deployment /usr/local/bin/deployment
RUN chmod +x /usr/local/bin/deployment
EXPOSE 8080
CMD ["deployment"]

