FROM juniper/pyez:latest

LABEL net.juniper.ps.automation.description="base robot testing container" \
      net.juniper.ps.automation.maintainer="Paul Plavetzki"

RUN pip install -U robotframework robotframework-selenium2library xmltodict librabbitmq pika
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk upgrade \
	&& apk add --no-cache tini python3 libstdc++ openblas freetype wget ca-certificates \
	&& python3 -m ensurepip && rm -r /usr/lib/python*/ensurepip \
	&& pip3 install --upgrade pip setuptools \
	&& apk add --no-cache --virtual .build-deps@testing python3-dev make cmake clang clang-dev g++ linux-headers libtbb@testing libtbb-dev@testing openblas-dev freetype-dev \
        && pip3 install ansible ansible-lint;
