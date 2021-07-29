import paho.mqtt.client as mqtt
import time
import datetime
import random
import string

letters = string.ascii_lowercase

def on_connect(client, userdata, flags, rc):
    print(f"CONNACK received with code: {rc}")

def on_publish(client, userdata, mid):
    print(f"mid: {mid}")

def on_log(client, userdata, level, buf):
    print(f"{buf} retain={client._will_retain}")
    
broker = "localhost"
port = 1883
rand_string = ''.join(random.choice(letters) for i in range(3))
client_name = f"py_mqtt_{rand_string}"
client = mqtt.Client(client_name)
client.will_set("test", qos=1, retain=True)
client.on_connect = on_connect
client.on_log = on_log
client.connect(broker, port, keepalive=60)
client.on_publish = on_publish

while True:
    temp = random.randint(0,100)
    timestamp = round(datetime.datetime.now().timestamp()*(10**9))
    point = f"temp value={temp} {timestamp}"
    (rc, mid) = client.publish(f"/things/{client_name}/temp", point, 2, retain=True)
    print(f"payload: {point}")
    time.sleep(2)

