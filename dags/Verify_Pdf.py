from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime, timedelta

def greet(ti, **context):
    titulo = context['dag_run'].conf['Titulo']
    print("change")
    raise ValueError("The parameters are not well done")


args = {
    'owner': 'brock',
    'depends_on_past': False,
    'start_date': days_ago(2),
    'email': ['brocktibert@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(seconds=7),
    'schedule_interval': None,
    'provide_context': True
}

with DAG(
    dag_id='verify_pdf_v1',
    default_args=args,
    tags=["Rafita"]
) as dag:
    task1 = PythonOperator(
        task_id="greet",
        python_callable = greet
    )