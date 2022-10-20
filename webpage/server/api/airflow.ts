import type { IncomingMessage, ServerResponse } from "http";
import * as url from "url";


function getRandomInt(max) {
    return Math.floor(Math.random() * max);
  }

export default async(req: IncomingMessage, res: ServerResponse) => {
    //const queryobject = url.parse(req.url as string, true).query;
    //const { search } = queryobject;
    let count_id = getRandomInt(1000)
    let airflow = {
        conf: {grid:"10298","sid":1,"date_start":"2022-10-13","date_end":"2022-10-16","title": "upload.title","desc": "upload.description"},
        dag_run_id: count_id.toString()
    }
    let user = "Basic "+ btoa("airflow:airflow")
    const requestOptions = {
        header: {"Authorization": user},
        method: 'POST',
        body: JSON.stringify(airflow)
      }
    const endpoint = 'http://localhost:8080/api/v1/dags/verify_pdf_v1/dagRuns';
    const data = await $fetch(endpoint,requestOptions);


    res.writeHead(200,{"Content-Type": "application/json"});
    res.write(JSON.stringify(data));
    res.end();
};