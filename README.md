# mqtt_sandbox

![Architecture](imgs/architecture.png)

## Usage
Set environment variables Docker host machine:
- DOCKER_INFLUXDB_INIT_USERNAME
    - Username for logging into InfluxDB
- DOCKER_INFLUXDB_INIT_PASSWORD
    - Password for logging into InfluxDB
- DOCKER_INFLUXDB_INIT_ORG=${INFLUX_ORG}
    - InfluxDB Organization name
- DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
    - Token for InfluxDB admin authorization (the `influx_cli` container will need this)