import "strings"
import "experimental/mqtt"
import "influxdata/influxdb/schema"

option v = {
    timeRangeStart: -5m,
    timeRangeStop: now()
}

option task = {
    name: "cpu_avg_5m",
    every: 1m,
}
 
record = schema.tagValues(bucket: "mqtt", tag: "host")
    |> last()
    |> findRecord(fn: (key) => true, idx: 0)
    
device_name = string(v: record._value)
 
topic = strings.joinStr(arr: ["/processed", device_name, "cpu", "average"], v: "/")
 
from(bucket: "mqtt")
    |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
    |> filter(fn: (r) => r["_measurement"] == "cpu")
    |> filter(fn: (r) => r["_field"] == "usage_user")
    |> filter(fn: (r) => r["cpu"] == "cpu-total")
    |> mean()
    |> drop(columns: ["host"])
    |> pivot(rowKey:["_stop"], columnKey: ["_field"], valueColumn: "_value")
    |> rename(columns: {usage_user: "mean_usage_user"})
    |> mqtt.to(broker: "broker:1883", topic: topic, timeColumn: "_stop", valueColumns: ["mean_usage_user"])