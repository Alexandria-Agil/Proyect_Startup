from typing import Union
from fastapi import FastAPI
from pydantic import BaseModel
from airflow import airflow_dag_trigger
import requests

app = FastAPI()
GenericDag = "DagName"

class Config(BaseModel):
    grid: Union[str, None] = None
    sid: Union[str, None] = None
    date_start: Union[str, None] = None
    date_end: Union[str, None] = None
    title: Union[str, None] = None
    desc: Union[str, None] = None

class Dag(BaseModel):
    dag_run_id: str
    conf: Config

class Status(BaseModel):
    status: str


@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/Dag/")
async def create_item(data: Dag):
    print(data)
    Dag_item = Dag(dag_run_id = data.dag_run_id, conf = data.conf)
    print(Dag_item)
    airflow_response = airflow_dag_trigger(Dag_item)
    return airflow_response


@app.post("/status/")
async def create_item(complete: Status):
    requests.post("http://localhost:5000/validation", json={"id": complete.status})
    return 