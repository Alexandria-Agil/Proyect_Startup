<template>
    <v-layout color="grey-lighten-3">
        <v-app-bar color="teal-darken-4" image="https://iili.io/snGjtf.jpg">
            <template v-slot:image>
                <v-img gradient="to top right, rgba(19,84,122,.8), rgba(128,208,199,.8)"></v-img>
            </template>

            <template v-slot:prepend>
                <v-app-bar-nav-icon @click="drawer_active()"></v-app-bar-nav-icon>
            </template>

            <a href="/" style="text-decoration: none; color: inherit;">
                <v-app-bar-title>Alexandria Archives</v-app-bar-title>
            </a>

            <v-spacer></v-spacer>
            <div v-if="!Loged">
            <a href="/signin" style="text-decoration: none; color: inherit;">
                <v-btn style="border: 1px solid #000; margin-right: 10px;" >
                    Sign In
                </v-btn>
            </a>
            <a href="/login" style="text-decoration: none; color: inherit;">
                <v-btn style="border: 1px solid #000; margin-right: 15px;" >
                    Log in
                </v-btn>
            </a>
            </div>
            <div v-else>
                <a href="/usuarios/1" style="text-decoration: none; color: inherit;">
                <v-btn style="border: 1px solid #000; margin-right: 15px;" >
                    Profile
                </v-btn>
            </a>
            </div>
            <v-form ref="form" v-on:submit.prevent="searchItems" style="width: 400px;">
                    <v-container>
                        <v-row>
                            <v-text-field v-model="searchText" class="input" hide-details label="Search"
                                placeholder="Search" rounded dense single-line>
                            </v-text-field>

                            <v-btn icon type="submit">
                                <v-icon>mdi-magnify</v-icon>
                            </v-btn>
                        </v-row>
                    </v-container>
            </v-form>
            
        </v-app-bar>
        <v-navigation-drawer ref="navDrawer" id="navDrawer" v-model="drawer" app location="left" temporary
            style="width: 300px;">
            <div v-if="!Loged">
                <h2 style="color: white;">U need to Log in to see this functions </h2>         
            </div>
            <div v-else>
                <a href="/uploadPDF" style="text-decoration: none; color: inherit;">
                    <v-btn style="border: 1px solid #000;width: 300px;" class="top_separation" >
                        Upload a PDF
                    </v-btn>
                </a>

                <a href="/friends" style="text-decoration: none; color: inherit;">
                    <v-btn style="border: 1px solid #000;width: 300px;" class="top_separation" >
                        See Friends
                    </v-btn>
                </a>

                <a href="/privatepdf" style="text-decoration: none; color: inherit;">
                    <v-btn style="border: 1px solid #000;width: 300px;" class="top_separation">
                        Private PDF
                    </v-btn>
                </a>
                
                <a href="/" style="text-decoration: none; color: inherit;">
                    <v-btn style="border: 1px solid #000;width: 300px;color: red;margin-top: 15px;" class="top_separation" @click="logout()">
                       Log out
                    </v-btn>
                </a>
            </div>
        </v-navigation-drawer>
    </v-layout>
</template>

<script setup lang="ts">
let drawer = ref<boolean>(false)
const searchText = ref<string>("")

function drawer_active(): void {
    drawer.value = !(drawer.value)
}

function searchItems(): void {
    const router = useRouter()
    router.push({ name: 'search', query: { search: searchText.value } })
    
    
}


  let Loged = false
  const Token = useCookie('Token')
  const value = Token.value
  const url = "http://127.0.0.1:5000/users"
    const requestOptions = {
    method: 'GET',
    headers: {"Authorization":value}
  }
  const { data, error, refresh, pending } = await useFetch<JSON>(url, requestOptions);
  console.log(data)
  refresh();
  console.log(JSON.parse(JSON.stringify(data)))
    try{
      if(value != undefined){
        Loged = true
      }
    }
    catch(e){
      console.log(e)
      console.log(data)
    }
   
  
  
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
  console.log(Loged)

function logout()
  {
    const Token = useCookie('Token')
    Token.value = undefined
    console.log(Token.value)

  }

</script>

<style>
.v-navigation-drawer {
    background-color: rgba(19, 84, 122, .8);
    z-index: 2;
}

.top_separation{
    margin-top: 2px;
}


</style>
