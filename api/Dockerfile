# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /mqtt_api

COPY ./mqtt_api .

RUN pip3 install -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "api:app", "--host", "0.0.0.0"]