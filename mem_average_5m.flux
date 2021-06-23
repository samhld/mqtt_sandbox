import "strings"
import "experimental/mqtt"
import "influxdata/influxdb/schema"

option v = {
    timeRangeStart: -5m,
    timeRangeStop: now()
}

option task = {
    name: "mem_avg_5m",
    every: 1m,
}
 
record = schema.tagValues(bucket: "mqtt", tag: "host")
    |> last()
    |> findRecord(fn: (key) => true, idx: 0)
    
device_name = string(v: record._value)
 
topic = strings.joinStr(arr: ["/processed", device_name, "mem", "average"], v: "/")
 
from(bucket: "mqtt")
    |> range(start: -5m)
    |> filter(fn: (r) => r["_measurement"] == "mem")
    |> filter(fn: (r) => r["_field"] == "used")
    |> mean()
    |> drop(columns: ["host"])
    |> pivot(rowKey:["_stop"], columnKey: ["_field"], valueColumn: "_value")
    |> rename(columns: {used: "mean_used"})
    |> mqtt.to(broker: "broker:1883", topic: topic, timeColumn: "_stop", valueColumns: ["mean_used"])