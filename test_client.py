import paho.mqtt.client as mqtt
import random
import json
import argparse
import logging

logger = logging.getLogger(__name__)

def on_connect(client, userdata, flags, rc):
    print(f"CONNACK received with code: {rc}")
    print("SUBSCRIBING to Topic: 'things/temp/average'")

def on_disconnect(client, userdata, rc):
    print(f"DISCONNECT code: {rc}")

def on_publish(client, userdata, mid):
    print(f"PUBLISH mid: {mid}")

def on_log(client, userdata, level, buf):
    print(f"{buf} retain={client._will_retain}")

def on_subscribe(client, userdata, mid, granted_qos):
    print(f"SUBSCRIBE: mid: {mid} granted qos: {granted_qos}")

def on_message(client, userdata, msg):
    print(f"Incoming message:\n\tTopic: {msg.topic}\n\tPayload: {msg.payload.decode('utf-8')}")
    
broker = "localhost"
port = 1883
client = mqtt.Client("test_client")
client.on_connect = on_connect
client.on_publish = on_publish
client.on_disconnect = on_disconnect
client.on_subscribe = on_subscribe
client.on_message = on_message
client.connect(broker, port, keepalive=10)
client.loop_start()

try:
    loop = True
    while loop:
        try:
            client.subscribe("json/things/+/temp")
        except:
            logger.error("error during subscription")
            loop = False
    
except Exception as e:
    logger.error(f"Error:{e}")
    client.disconnect()
    client.loop_stop()
