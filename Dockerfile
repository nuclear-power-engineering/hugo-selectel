FROM golang AS build-env

ADD selectelupload /go/src/github.com/djbelyak/selectelupload

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /go/bin/selectelupload github.com/djbelyak/selectelupload

FROM alpine:3.4
MAINTAINER Ivan Belyavtsev <djbelyak@gmail.com>

ENV HUGO_VERSION 0.27.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /tmp

COPY --from=build-env /go/bin/selectelupload /usr/local/bin/

# Install bash and tools
RUN apk update && \
    apk add tar && \
    tar -xvf /tmp/${HUGO_BINARY}.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/selectelupload /usr/local/bin/hugo && \
    rm /tmp/${HUGO_BINARY}.tar.gz && \
    apk del tar && rm -rf /var/cache/apk/* && \
    mkdir /data 

WORKDIR /data

