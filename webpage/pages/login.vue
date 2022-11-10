<template>



<div class="float-container">

  <div class="float-child">
      <div v-if="!Loged">
        <form @submit.prevent="userLogin" class="form">
          <div>
            <label>Username</label>
            <input type="text" v-model="login.username" class="separate_input inputs"/>
          </div>
          <div>
            <label>Password</label>
            <input type="text" v-model="login.password" class="separate_input inputs"/>
          </div>
          <div>
            <button type="submit">Submit</button>
          </div>
        </form>
      </div>
      <div v-else>
        Tu ya estas logeado
      </div>
  </div>
  
  <div class="float-child">
    <img src="https://delatierramedia.com/wp-content/uploads/2020/12/libro-el-sen%CC%83or-de-los-anillos.jpg">
  </div>
  
</div>



    </template>
  
  <script setup lang="ts">
  const router = useRouter();
  let Loged = false
  const Token = useCookie('Token')
  const value = Token.value

   
  
  
  const login = {
          username: '',
          password: ''
        }


definePageMeta({
    key: route => route.fullPath
})

  async function userLogin()
  {
    const url = "http://host.docker.internal:5000/login"
    const requestOptions = {
    method: 'POST',
    headers: {},
    body: JSON.stringify(login)
    }
    const { data } = await useFetch<JSON>(url, requestOptions);
    const Token = useCookie('Token')
    console.log(data)
    console.log(data.value)
    Token.value = data.value.token.toString()
    console.log(Token.value)
    if(Token.value != undefined){

      router.push({ path: "/" });
    }
  }
  
  
  </script>


<style>
.separate_input{
  margin-left: 10px;
}

.inputs{
    border: 1px solid #555;
    border-radius: 25px;
}
.form{
  margin-top: 150px;
  margin-left: 200px;
}

.float-container {
    border: 3px solid #fff;
    padding: 20px;
}

.float-child {
    width: 50%;
    float: left;
    padding: 20px;

} 
</style>