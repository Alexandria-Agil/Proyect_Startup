# Dockerfile, Image, Container

FROM python:3-buster

WORKDIR /API
COPY . /API

RUN pip install -r requirements.txt

CMD ["stdbuf","-oL",  "python", "-u","main.py"]
