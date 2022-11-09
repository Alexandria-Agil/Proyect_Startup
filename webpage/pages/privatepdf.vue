<template>
    <br><br><br>
    <h2>Your Uploads</h2>
    <v-table>
        <tr v-for="item in products" :key="item.mal_id">

                <td>
                    <v-card color="transparent" height="200" width="300">
                        <a :href="`pdf/${item.mal_id}`" style="text-decoration: none; color: inherit;">
                        <v-img class="d-flex fill-height align-center justify-center" :src="item.images.jpg.image_url">
                        </v-img>
                    </a>
                    </v-card>
                </td>
                <td style="margin-bottom: 100px;">
                    <a :href="`pdf/${item.mal_id}`" style="text-decoration: none; color: inherit;">
                        {{ item.title }}
                    </a>
                </td>

    
        </tr>
    </v-table>
</template>


<script setup lang="ts">
const { data } = await useFetch<any>("https://api.jikan.moe/v4/manga");
const router = useRouter()
const route = useRoute()

const products = computed<any[]>(() => {
    const TotalData = data.value.data
    const searchQuery = route.query.search as string;
    if (!searchQuery) return TotalData;
    const upperQuery = searchQuery.toUpperCase();
    return TotalData.filter((product) => {
        return product.title.toUpperCase().includes(upperQuery);
    })
    
})

definePageMeta({
    key: route => route.fullPath
})
</script>
    
<script lang="ts">
export default {
    layout: "default",
};
</script>
    