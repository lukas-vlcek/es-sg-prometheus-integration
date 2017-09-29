#!/bin/bash

set -ex

./initialize_sg.sh &

exec ${ES_HOME}/bin/elasticsearch \
	--path.conf=${ES_CONF} \
	--security.manager.enabled false
