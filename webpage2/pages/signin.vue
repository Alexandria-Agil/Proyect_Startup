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
  const url = "http://127.0.0.1:5000/register"
  const requestOptions = {
  method: 'POST',
  headers: {},
  body: JSON.stringify(login),
  }
  const { data, error } = useFetch<any>(url, requestOptions);
  
  console.log(error)
}


</script>