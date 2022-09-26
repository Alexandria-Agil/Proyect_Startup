<template>
  <br/><br/><br/>
    <div>
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
  </template>

<script setup lang="ts">

const login = {
        username: '',
        password: ''
      }
async function userLogin()
{
    try {
        let response = await this.$auth.loginWith('local', { data: this.login })
        console.log(response)
      } catch (err) {
        console.log(err)
    }
}


</script>