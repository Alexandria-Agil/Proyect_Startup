from typing import Union
from fastapi import FastAPI
from pydantic import BaseModel
from airflow import airflow_dag_trigger
app = FastAPI()
GenericDag = "DagName"

class Config(BaseModel):
    grid: Union[str, None] = None
    sid: Union[str, None] = None
    date_start: Union[str, None] = None
    date_end: Union[str, None] = None
    Title: Union[str, None] = None

class Dag(BaseModel):
    dag_run_id: str
    conf: Config


@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/Dag/")
async def create_item(Dag: Dag):
    airflow_response = airflow_dag_trigger(Dag)
    return airflow_response