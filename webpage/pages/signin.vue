<template>


    <div class="float-container">

  <div class="float-child">
    <div>
      <form @submit.prevent="usersignin" class="form">
        <div>
          <label>Username</label>
          <input type="text" v-model="login.username" class="separate_input inputs"/>
        </div>
        <div>
          <label>Email</label>
          <input type="email" v-model="login.email" class="separate_input inputs"/>
        </div>
        <div>
          <label>Password</label>
          <input type="text" v-model="login.password" class="separate_input inputs" />
        </div>
        <div>
          <button type="submit">Submit</button>
        </div>
      </form>
    </div>
  </div>

  <div class="float-child">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Manga_collection_of_Lone_Wolf_and_Cub.jpg/1280px-Manga_collection_of_Lone_Wolf_and_Cub.jpg" class="images">
  </div>

</div>
  </template>

<script setup lang="ts">
const router = useRouter();
const login = {
        username: '',
        email: '',
        password: ''
      }
async function usersignin()
{
  const url = "http://127.0.0.1:5000/register"
  const requestOptions = {
  method: 'POST',
  headers: {},
  body: JSON.stringify(login),
  }
  const { data, error } = useFetch<any>(url, requestOptions);
  console.log(data)
  console.log(error)
  console.log("value")
  console.log(data.value)

  router.push({ path: "/" });

  
}


</script>

<style>
.separate_input{
  margin-left: 10px;
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
.images{
  margin-top: 100px;
  height: 400px;
}

.inputs{
    border: 1px solid #555;
    border-radius: 25px;
}
</style>