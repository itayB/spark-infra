#!/bin/bash

set -e

env

export SPARK_HOME=/usr/local/spark
. "${SPARK_HOME}/sbin/spark-config.sh"
. "${SPARK_HOME}/bin/load-spark-env.sh"

mkdir -vp ${SPARK_WORKER_LOG}

ln -vsf /dev/stdout ${SPARK_WORKER_LOG}/spark-worker.out

COMMAND="${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.worker.Worker ${SPARK_MASTER}\
  --webui-port ${SPARK_WORKER_WEBUI_PORT}\
  --cores ${CORE_COUNT}\
  --memory ${EXECUTOR_MEMORY}"

echo "${COMMAND}"
eval "${COMMAND}"
