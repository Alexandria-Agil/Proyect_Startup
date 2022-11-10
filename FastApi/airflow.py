from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
from retrying import retry
import requests
import json
import os

import requests


#@retry(stop_max_attempt_number=10, wait_fixed=2000)
def airflow_dag_trigger(param):
    try:
        header = {
            'Content-Type': 'application/json',
            'Cache-Control': 'no-cache'
        }
        retry_strategy = Retry(total=10, backoff_factor=1, status_forcelist=[500, 400], method_whitelist=["POST"])
        http = requests.Session()
        response = requests.post('http://192.168.0.3:8080/api/v1/dags/verify_pdf_v1/dagRuns',headers = header, json = json.loads(param.json()), auth=('airflow', 'airflow'))
        return response.json()
    except Exception as e:
        print("Error initializing DAG")
        raise
