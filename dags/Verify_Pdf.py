from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime, timedelta

TITLE_MAX_CHAR = 100
DESC_MAX_CHAR = 500

def pdf_filter(ti, **context):
    title = context['dag_run'].conf['title']
    desc = context['dag_run'].conf['description']
    if len(title) > TITLE_MAX_CHAR:
        raise ValueError(f"The title is too large, has {len(title)} chars (MAX: {TITLE_MAX_CHAR})")
    elif len(desc) > DESC_MAX_CHAR:
        raise ValueError(f"The description is too large, has {len(desc)} chars (MAX: {DESC_MAX_CHAR})")
    return 0
    
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
    tags=["Filter"]
) as dag:
    task1 = PythonOperator(
        task_id="pdf_filter",
        python_callable = pdf_filter
    )