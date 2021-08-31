# Example Input:
# temp,topic=json/things/76514feb108b/temp value=45
#
# Example Output:
# temp,format=json,group=things,device_id=76514feb108b value=45

def apply(metric):
    parsed_topic = metric.tags["topic"].split("/")
    if len(parsed_topic) == 4:
        metric.tags["format"] = parsed_topic[0]
        metric.tags["group"] = parsed_topic[1]
        metric.tags["device_id"] = parsed_topic[2]
    else:
        metric.tags["format"] = "lp"
        metric.tags["group"] = parsed_topic[0]
        metric.tags["device_id"] = parsed_topic[1]
    metric.tags.pop("topic")
    # metric.tags.pop("host")
    return metric