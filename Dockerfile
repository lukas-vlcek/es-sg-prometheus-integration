FROM	centos:latest

EXPOSE	9200
EXPOSE	9300
USER	0

ENV	ES_VER=2.4.5 \
	ES_CONF=/usr/share/java/elasticsearch/config \
	SG_VER=2.4.5.12 \
	SG_SSL_VER=2.4.5.21 \
	SG_SSL_GIT_TAG=ves-2.4.5-21 \
	PROMETHEUS_EXPORTER_VER=2.4.4.0 \
	JAVA_VER=1.8.0 \
	ES_HOME=/usr/share/java/elasticsearch \
	HOME=/opt/app-root/src \
	TMP_DIR=/tmp

ARG	PROMETHEUS_PLUGIN=true

RUN	yum install -y --setopt=tsflags=nodocs \
		wget \
		unzip \
		git \
		openssl \
		java-${JAVA_VER}-openjdk-headless && \
	yum clean all

ADD	start_es.sh install.sh configure_sg.sh initialize_sg.sh ${HOME}/
ADD prometheus-exporter/*.zip ${HOME}/

RUN	${HOME}/install.sh

ADD	config/elasticsearch.yml ${ES_HOME}/config/
ADD	config/logging.yml ${ES_HOME}/config/
ADD	config/sg_*.yml ${ES_HOME}/config/

WORKDIR	${HOME}
USER	1000
CMD	["sh", "/opt/app-root/src/start_es.sh"]
