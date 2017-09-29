#!/bin/bash

set -ex

sleep 15

### Initialize Search Guard 2 plugin
cd ${ES_HOME}

echo "======= Running sgadmin tool" >> ${ES_HOME}/logs/elasticsearch.log

plugins/search-guard-2/tools/sgadmin.sh \
  -cd ${ES_CONF}/ \
  -ks plugins/search-guard-2/sgconfig/transport-node-0-keystore.jks \
  -ts plugins/search-guard-2/sgconfig/truststore.jks \
  -nhnv

echo "======= sgadmin too finished" >> ${ES_HOME}/logs/elasticsearch.log
