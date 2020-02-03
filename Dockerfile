#This will prepare a elasticsearch node with mongo-connector enabled

FROM python:3-buster

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Berlin

RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update && apt-get install -y mongodb-org-shell


# Installing Mongo Connector which will connect MongoDB and Elasticsearch
RUN pip install 'mongo-connector[elastic5]==3.1.1'

COPY startup.sh /tmp/

RUN chmod +x /tmp/startup.sh

VOLUME /data

# Sample usage when no commands is given outside
CMD ["/bin/bash", "/tmp/startup.sh"]

