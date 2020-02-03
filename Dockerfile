#This will prepare a elasticsearch node with mongo-connector enabled

FROM python:3-buster

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Berlin

# Installing Mongo Connector which will connect MongoDB and Elasticsearch
RUN pip install 'mongo-connector[elastic5]==3.1.1'

COPY startup.sh /tmp/

VOLUME /data

# Sample usage when no commands is given outside
CMD ["/bin/bash", "/tmp/startup.sh"]

