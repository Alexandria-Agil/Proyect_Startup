<template>
    <br/><br/><br/>
      <div v-if="!Loged">
        <form @submit.prevent="userLogin">
          <div>
            <label>Username</label>
            <input type="text" v-model="login.username" />
          </div>
          <div>
            <label>Password</label>
            <input type="text" v-model="login.password" />
          </div>
          <div>
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
      <div v-else>
        Tu ya estas logeado
      </div>
    </template>
  
  <script setup lang="ts">
  let Loged = false
  const Token = useCookie('Token')
  const value = Token.value
  const { data, refresh } = await useFetch<JSON>("/api/user",{headers:{"Authorization": value}});
  console.log("value is: ")
  console.log(value)
    try{
      Loged = data.value.status
    }
    catch(e){
      console.log(e)
      console.log(data)
    }
   
  refresh();
  
  const login = {
          username: '',
          password: ''
        }
  async function userLogin()
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