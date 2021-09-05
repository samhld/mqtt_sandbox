# mqtt_sandbox

![Architecture](imgs/architecture.png)

## Usage
Before running, set environment variables for your Docker host machine:
- `INFLUX_ORG`
    - Maps to `DOCKER_INFLUXDB_INIT_ORG` environment variable in `influxd` container
    - The organization name (can be whatever you want)
- `INFLUX_HOST`
    - Maps to `DOCKER_INFLUX_INIT_HOST`
    - Best to set this to `http://host.docker.internal:8086`
- `INFLUX_BUCKET`
    - Maps to `DOCKER_INFLUXDB_INIT_BUCKET`
    - Whatever you want
- `INFLUX_USERNAME`
    - Maps to `DOCKER_INFLUXDB_INIT_USERNAME`
    - Username for logging into InfluxDB
- `INFLUX_PASSWORD`
    - Maps to `DOCKER_INFLUXDB_INIT_PASSWORD`
    - Password for logging into InfluxDB
- `INFLUX_TOKEN`
    - Maps to `DOCKER_INFLUXDB_INIT_ADMIN_TOKEN`
    - Token for InfluxDB admin authorization (the `influx_cli` container will need this)
- `INFLUXDB_V2_DATA_PATH`
    - Set your own path to a volume on your host machine

Next, make sure you're in the directory with the `docker-compose.yml` file contained in the repo.  Then run `docker-compose up -d`

There is no data yet so you will have to spin up data-generating clients:
* In the top level directory of the repo, `chmod 755 run_pub_clients.sh <args>`.
* Now run `./run_pub_clients.sh` with any arguments you wish to change from default, which are:
  - `-i`: Interval (in seconds) = 5 # seconds between publishing a value
  - `-n`: Number = 5 --> number of clients to spin up
  - `-f`: Format = value --> the format to write data in (can be `value`, `json-value`, `json`, `lp`)

Formats:
  * `value` = a single value with no context.  This will write to a topic that holds context for the value.
  * `json-value` = a single value written as a JSON object.  Again, context will be in topic.
  * `json` = a JSON object that holds the value and the context.  The topic will not have context to show how you can place context in either place...or both.
  * `lp` = a single value written in Influx Line Protocol.  Context will be in topic.

From there you can take your browser to the following ports on `localhost`:
- :8086
    - This is the InfluxDB UI
    - Log in with the username and password you set in your environment variables
- :8080
    - This is the HiveMQ UI
    - Log in with their defaults (username=`admin`, password=`hivemq`)
- :1880
    - This is Node-Red
    ![Node-Red Flow](imgs/node-red-flow.png)
    - There is a Flow aready created for you. However, you'll need to "load" it grab your InfluxDB Token.  To load it:
        - copy the `node-red.json` text in the root of the repo
        - navigate in the UI to the "hamburger" in the upper-right and click "Import"
        - with "Clipboard" selected, paste in the JSON, make sure "current flow" is selected at the bottom, and "Import"
    - From here, double click the "_influxdb destination_" node, click the pencil icon to the right of "Server" to edit its settings and enter your Token into the "Token" field, and Update, and Done.

