<template>
    <br><br><br>
    <h2>Your Uploads</h2>
    <div v-if="largo != 0">
        <v-table>
            <tr v-for="item in datos" :key="item.name">

                    <td style="width: 300px;">
                        <v-card color="transparent" height="200" width="300">
                            <a :href="`pdf/${item.id}`" style="text-decoration: none; color: inherit;">
                            <img v-bind:src="'data:image/jpeg;base64,'+item.image" class="d-flex fill-height align-center justify-center" />
                        </a>
                        </v-card>
                    </td>
                    <td style="margin-bottom: 100px; padding-left: 50px;">
                        <a :href="`pdf/${item.id}`" style="text-decoration: none; color: inherit;">
                            {{ item.name }}
                        </a>
                    </td>
                    <td style="margin-bottom: 100px; padding-left: 50px;">
                        <a :href="`pdf/${item.id}`" style="text-decoration: none; color: inherit;">
                            {{ item.descr }}
                        </a>
                    </td>

            </tr>
        </v-table>
    </div>
    <div v-else>
        <h2>No tienes PDF subidos</h2>
    </div>
</template>


<script setup lang="ts">

const Token = useCookie('Token')
const url = "http://host.docker.internal:5000/files"
const requestOptions = {
method: 'GET',
headers: {"Authorization":Token.value},
}
const { data } = await useFetch<any>(url, requestOptions);
console.log(data.value)
let largo = data.value.status.length
let datos = data.value.status



definePageMeta({
    key: route => route.fullPath
})
</script>
    
<script lang="ts">
export default {
    layout: "default",
};
</script>
    