# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /mqtt_client

COPY . .

RUN pip3 install -r requirements.txt

CMD ["python3", "/mqtt_client/mqtt_client.py"]