<template>
  <v-table>
    <v-carousel :show-arrows="true">
      <v-carousel-item v-for="(item,i) in items" :key="i" :src="item.src" cover></v-carousel-item>
    </v-carousel>
    <v-container fluid>
      <v-row dense>
        <v-col v-for="n in 8" :key="n" cols="3">
          <v-sheet color="grey-lighten-2" height="96"></v-sheet>
        </v-col>
      </v-row>
    </v-container>

    <v-sheet class="mx-auto" elevation="8" max-width="1800">
      <v-slide-group v-model="model" class="pa-4" selected-class="bg-primary" show-arrows>
        <v-slide-group-item v-for="(item,i) in manga" :key="i"  v-slot="{ isSelected, toggle, selectedClass }"  >
          <v-card color="red" :class="['ma-4', selectedClass]" height="200" width="100" @click="toggle" >
            <v-img class="d-flex fill-height align-center justify-center" :src="item.jpg.image_url">
              <v-scale-transition>
                <v-icon v-if="isSelected" color="white" size="48" icon="mdi-close-circle-outline"></v-icon>
              </v-scale-transition>
            </v-img>
          </v-card>
        </v-slide-group-item>
      </v-slide-group>

      <v-expand-transition>
        <v-sheet v-if="model != null" height="200">
          <div class="d-flex fill-height align-center justify-center">
            <h3 class="text-h6">
              Selected {{ model }}
            </h3>
          </div>
        </v-sheet>
      </v-expand-transition>
    </v-sheet>

  </v-table>


</template>
  
  
<script setup lang="ts">
import Manga from '@/types/file';
const { data } = await useFetch<any>("https://api.jikan.moe/v4/manga/2/pictures");

const manga = data.value.data;

//console.log(manga)



const model = ref(null)
const items = [
  {
    src: 'https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg',
  },
  {
    src: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg',
  },
  {
    src: 'https://cdn.vuetifyjs.com/images/carousel/bird.jpg',
  },
  {
    src: 'https://cdn.vuetifyjs.com/images/carousel/planet.jpg',
  },
]

definePageMeta({
  key: route => route.fullPath
})
</script>
    
<script lang="ts">
export default {
  layout: "default",
};
</script>

<style>
.v-carousel {
  margin-top: 5%;
  z-index: 1;
}
</style>