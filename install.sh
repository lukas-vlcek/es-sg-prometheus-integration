#!/bin/bash

set -ex

echo ${ES_VER}
echo ${ES_HOME}
echo ${ES_CONF}
echo ${TMP_DIR}
echo ${SG_VER}
echo ${SG_SSL_VER}
echo ${PROMETHEUS_EXPORTER_VER}
echo ${PROMETHEUS_PLUGIN}

wget -O /tmp/es.zip "https://oss.sonatype.org/service/local/artifact/maven/redirect?r=releases&g=org.elasticsearch.distribution.zip&a=elasticsearch&e=zip&v=${ES_VER}"
unzip /tmp/es.zip -d ${TMP_DIR}
mv /tmp/elasticsearch-${ES_VER} ${ES_HOME}


# Install SearchGuard plugins (SSL, SG2)
${ES_HOME}/bin/plugin install -b com.floragunn/search-guard-ssl/${SG_SSL_VER}
${ES_HOME}/bin/plugin install -b com.floragunn/search-guard-2/${SG_VER}

# Configure Search Guard
${HOME}/configure_sg.sh

if [ "${PROMETHEUS_PLUGIN}" = "true" ]; then

  # Install Prometheus exporter plugin
  ${ES_HOME}/bin/plugin install -b https://github.com/vvanholl/elasticsearch-prometheus-exporter/releases/download/${PROMETHEUS_EXPORTER_VER}/elasticsearch-prometheus-exporter-${PROMETHEUS_EXPORTER_VER}.zip

fi

chmod -R og+w ${ES_CONF} ${ES_HOME} ${HOME}
