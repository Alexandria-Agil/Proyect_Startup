<template>
    <br/><br/><br/>


    <form @submit.prevent="uploadPDF">
          <div>
            <label>PDF Name</label>
            <input type="text" v-model="login.Name" class="separate_input"/>
          </div>
          <div>
            <label>Description</label>
            <input type="text" v-model="login.Name" class="separate_input"/>
          </div>
          <div>
            <label>Select PDF file to upload</label>
            <input type="file" v-on:change="login.File" name="file" id="fileUp" class="separate_input">
          </div>
          <div>
            <label>Upload a cover image</label>
            <input type="file" v-on:change="login.File" name="file" id="fileUp" class="separate_input">
          </div>
          <div>
            <button type="submit">Submit</button>
          </div>

    </form>


</template>

<script setup lang="ts">


  const login = {
          Name: '',
          File: ''
        }

async function uploadPDF()
  {
    const url = "http://127.0.0.1:5000/login"
    const requestOptions = {
    method: 'POST',
    headers: {},
    body: JSON.stringify(login)
    }
    const { data } = await useFetch<JSON>(url, requestOptions);
    const Token = useCookie('Token')
    Token.value = data.value.token.toString()
    console.log(Token.value)
  }


</script>



<style>
.separate_input{
  margin-left: 10px;
}
</style>