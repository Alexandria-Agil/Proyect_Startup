FROM apache/airflow:2.2.5-python3.8

## copy the content of local folder `./my_dag_folder` into container folder `/opt/airflow/dags`
USER root

COPY ./dags /opt/airflow/dags
RUN pip install -r requirements.txt

USER admin