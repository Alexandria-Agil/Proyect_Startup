<template>
    <br/><br/><br/>


      <form @submit.prevent="preproccesPDF" enctype = "multipart/form-data" class="form2">
          <div>
            <label>PDF Name</label>
            <input type="text" v-model="upload.title" class="separate_input" name = "title" />
          </div>
          <div>
            <label>Description</label>
            <input type="text" v-model="upload.description" class="separate_input" name = "description"/>
          </div>
          <div>
            <label>Select PDF file to upload</label>
            <v-file-input  type="file" @change="Setfile2" name = "file" class=" inputs2"
            truncate-length="15"
            ></v-file-input>
          </div>
          <div>
            <label>Upload a cover image</label>
            <v-file-input @change="Setfile1" name = "thumbnail" class=" inputs2"
            truncate-length="15"
            ></v-file-input>
          </div>
          <div>
            <button type="submit">Submit</button>
          </div>

    </form> 

</template>

<script setup lang="ts">
import { Body } from 'nuxt/dist/head/runtime/components';

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}



const Token = useCookie('Token')

  let upload = {
        title: '',
        file: new FormData(),
        thumbnail: new FormData(),
        description: ''

        }
    let dataset = new FormData()




    async function preproccesPDF()
  {
    let count_id = getRandomInt(1000)
    let airflow = {
        "conf": {grid:"10298","sid":1,"date_start":"2022-10-13","date_end":"2022-10-16","title": upload.title,"desc": upload.description},
        "dag_run_id": count_id.toString()
    }

    console.log("Basic "+ btoa("airflow:airflow"))
    let user = "Basic "+ btoa("airflow:airflow")
    console.log(airflow)
    const url = "http://127.0.0.1:8080/api/v1/dags/verify_pdf_v1/dagRuns"
    const requestOptions = {

    method: 'POST',
    body: JSON.stringify(airflow)
  }
    const { data } = await useFetch<any>(url, requestOptions);
    console.log(data)
  }

async function uploadPDF()
  {
    dataset.append("title",upload.title)
    dataset.append("description",upload.description)
    const url = "http://127.0.0.1:5000/upload"
    const requestOptions = {
    method: 'POST',
    headers: {"Authorization":Token.value},
    body: dataset
    }
    console.log(requestOptions.body)
    console.log(upload)
    const { data } = await useFetch<any>(url, requestOptions);
    console.log(data)
  }



  function Setfile1(e)
  {
    upload.thumbnail.append("img",e.target.files[0])
    dataset.append("thumbnail",e.target.files[0])

  }

  function Setfile2(e)
  {
    console.log(e.target.files[0])
    upload.file.append("pdf",e.target.files[0])
    dataset.append("file",e.target.files[0])

  }

</script>



<style>
.separate_input{
  margin-left: 10px;
}
.inputs2{
  width: 800px;
}
.form2{
  margin-left: 50px;
  margin-top: 10px;
}
</style>