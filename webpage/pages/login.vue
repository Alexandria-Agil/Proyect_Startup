<template>
    <br/><br/><br/>
      <div>
        <form @submit.prevent="userLogin">
          <div>
            <label>Username</label>
            <input type="text" v-model="login.username" />
          </div>
          <div>
            <label>Email</label>
            <input type="email" v-model="login.email" />
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
    </template>
  
  <script setup lang="ts">
  
  const login = {
          username: '',
          email: '',
          password: ''
        }
  async function userLogin()
  {
    const url = "http://localhost:5000/login"
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