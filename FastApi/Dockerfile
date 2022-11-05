FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

# requirements python
WORKDIR /code
COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN apt-get update \
    && apt-get install -y \
        netcat
# copy all the code
COPY . .


COPY ./main.py /code/

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

EXPOSE 8000
#ENTRYPOINT ["docker/entrypoint.sh"]
