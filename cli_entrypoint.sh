#!/bin/bash

influx setup --bucket mqtt -t ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN} -o ${DOCKER_INFLUXDB_INIT_ORG} --username=${DOCKER_INFLUXDB_INIT_USERNAME} --password=${DOCKER_INFLUXDB_INIT_PASSWORD} --host=http://influxd:8086 -f --skip-verify

influx task create -f /cpu_average_5m.flux