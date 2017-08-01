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
ADD https://raw.github.com/selectel/supload/master/supload.sh /usr/local/bin/supload.sh
RUN chmod +x /usr/local/bin/supload.sh

WORKDIR /data

