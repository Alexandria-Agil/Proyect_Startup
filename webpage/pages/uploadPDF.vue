<template>
    <br/><br/><br/>


      <form @submit.prevent="uploadPDF" enctype = "multipart/form-data">
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
            <v-file-input  type="file" @change="Setfile2" name = "file"
            truncate-length="15"
            ></v-file-input>
          </div>
          <div>
            <label>Upload a cover image</label>
            <v-file-input @change="Setfile1" name = "thumbnail"
            truncate-length="15"
            ></v-file-input>
          </div>
          <div>
            <button type="submit">Submit</button>
          </div>

    </form>


    <form action = "http://localhost:5000/upload" method = "POST" 
         enctype = "multipart/form-data">
         <input type = "file" name = "file" />
          <input type = "file" name = "thumbnail" />
          <input type = "text" name = "title" />    
          <input type = "text" name = "description" />
         <input type = "submit"/>
      </form>   

</template>

<script setup lang="ts">
import { Body } from 'nuxt/dist/head/runtime/components';

const Token = useCookie('Token')

  let upload = {
        title: '',
        file: new FormData(),
        thumbnail: new FormData(),
        description: ''

        }
    let dataset = new FormData()

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
</style>