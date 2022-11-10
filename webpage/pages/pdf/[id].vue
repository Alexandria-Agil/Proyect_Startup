<template>
    <br/><br/><br/>
    <h1>
        {{route.params.id}}
    </h1>
    <div v-if="data.value == undefined">
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
const url = "http://host.docker.internal:5000/file2/"+ 1
const requestOptions = {
method: 'GET',
headers: {"Authorization":Token.value},
}

const { data } = await useFetch<any>(url, requestOptions);
console.log(data.value)

console.log(id)


</script>