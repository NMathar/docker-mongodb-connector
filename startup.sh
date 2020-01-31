#!/bin/bash

mongo="${MONGO}"
elasticsearch="${ELASTICSEARCH:-elasticsearch}"
elasticport="${ELASTICPORT:-9200}"


mongo-connector --auto-commit-interval=0 --oplog-ts=/data/oplog.ts -m ${mongo} -t ${elasticsearch}:${elasticport} -d elastic2_doc_manager

cat /mongo-connector.log