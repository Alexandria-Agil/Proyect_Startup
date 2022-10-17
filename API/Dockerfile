# Dockerfile, Image, Container

FROM python:3-buster

WORKDIR /API
COPY . /API

RUN pip install -r requirements.txt

CMD [ "python", "-u","main.py"]
EXPOSE 5000
