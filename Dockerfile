FROM juniper/pyez:latest

LABEL net.juniper.ps.automation.description="base robot testing container" \
      net.juniper.ps.automation.maintainer="Paul Plavetzki"

RUN pip install -U robotframework robotframework-selenium2library xmltodict librabbitmq pika
