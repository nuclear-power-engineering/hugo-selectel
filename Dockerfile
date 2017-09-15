FROM golang AS build-env

ADD selectelupload /go/src/github.com/djbelyak/selectelupload

RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /go/bin/selectelupload github.com/djbelyak/selectelupload

FROM alpine:3.4
MAINTAINER Ivan Belyavtsev <djbelyak@gmail.com>

# Install bash and tools
RUN apk update && apk add py-pygments && apk add bash git curl && rm -rf /var/cache/apk/*


ENV HUGO_VERSION 0.25.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit

# Install hugo
RUN mkdir /usr/local/hugo && mkdir /data
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/hugo/
RUN ln -s /usr/local/hugo/hugo /usr/local/bin/hugo 

#Install supload
COPY --from=build-env /go/bin/selectelupload /usr/local/bin/
RUN chmod +x /usr/local/bin/selectelupload

WORKDIR /data

