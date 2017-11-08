FROM juniper/pyez:latest

LABEL net.juniper.ps.automation.description="base robot testing container" \
      net.juniper.ps.automation.maintainer="Paul Plavetzki"

RUN pip install -U robotframework robotframework-selenium2library xmltodict librabbitmq pika pymongo
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk update && apk upgrade \
	&& apk add --no-cache tini python3 libstdc++ openblas freetype wget ca-certificates \
	&& python3 -m ensurepip && rm -r /usr/lib/python*/ensurepip \
	&& pip3 install --upgrade pip setuptools \
	&& apk add --no-cache --virtual .build-deps@testing python3-dev make cmake clang clang-dev g++ linux-headers libtbb@testing libtbb-dev@testing openblas-dev freetype-dev \
    && wget  https://raw.githubusercontent.com/KamilBabayev/bell_robot/json_output/writer/json_writer.py \
 -O /usr/lib/python2.7/site-packages/robot/writer/json_writer.py \
    && echo "from .json_writer import create_json_output" >> /usr/lib/python2.7/site-packages/robot/writer/__init__.py \
    && echo "from .json_writer import write_json_todb" >> /usr/lib/python2.7/site-packages/robot/writer/__init__.py \
    && sed -i "46i from robot.writer import create_json_output, write_json_todb" /usr/lib/python2.7/site-packages/robot/run.py \
    && sed -i "453i \               \ xml_file, json_file = settings.output, settings.output_directory + '/output.json'" \
 /usr/lib/python2.7/site-packages/robot/run.py \
    && sed -i "454i \               \ create_json_output(xml_file, json_file)" /usr/lib/python2.7/site-packages/robot/run.py  \
    && sed -i "455i \               \ write_json_todb(json_file)" /usr/lib/python2.7/site-packages/robot/run.py \
    && pip3 install ansible ansible-lint;
