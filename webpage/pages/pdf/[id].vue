<template>
    <br/><br/><br/>
    <h1>
        {{route.params.id}}
    </h1>
    <div v-if="1==1">
        <embed :src=url width="500" height="500" 
        type="application/pdf">
    </div>
    <div v-else>
        <embed src="https://www.africau.edu/images/default/sample.pdf" width="500" height="500" 
        type="application/pdf">
    </div>

</template>

<script setup lang="ts">
import { stringify } from 'querystring';

const route = useRoute();
const id = route.params.id
console.log(id)
const Token = useCookie('Token')
const url = "http://127.0.0.1:5000/file2/"+ id
const requestOptions = {
method: 'GET',
headers: {"Authorization":Token.value},
}

const { data } = await useFetch<any>(url, requestOptions);

const objectUrl = URL.createObjectURL(data.value);


console.log(id)


</script>