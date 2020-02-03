#!/bin/bash

mongo="${MONGO}"
elasticsearch="${ELASTICSEARCH:-elasticsearch}"
elasticport="${ELASTICPORT:-9200}"

is_master_result="false"
expected_result="true"

while true;
do
  if [ "$is_master_result" != "$expected_result" ]; then
    is_master_result=`mongo ${mongo} --quiet --eval "d=db.isMaster(); print( d['ismaster'] );"`
    echo "Waiting for Mongod node to assume primary status..."
    sleep 3
  else
    echo "Mongod node is now primary"
    break;
  fi
done

sleep 1

mongo-connector --auto-commit-interval=0 --oplog-ts=/data/oplog.ts -m ${mongo} -t ${elasticsearch}:${elasticport} -d elastic2_doc_manager

cat /mongo-connector.log