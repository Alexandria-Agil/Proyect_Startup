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

            <a href="/signin" style="text-decoration: none; color: inherit;">
                <v-btn style="border: 1px solid #000; margin-right: 10px;" >
                    Sign In
                </v-btn>
            </a>


            <v-text-field class="input" hide-details label="Search Snow" placeholder="Search" v-model="searchText"
                rounded dense single-line>
            </v-text-field>

            <v-btn icon type="submit">
                <a href="/search">
                    <v-icon>mdi-magnify</v-icon>
                </a>

            </v-btn>
        </v-app-bar>
        <v-navigation-drawer ref="navDrawer" id="navDrawer" v-model="drawer" app location="left" temporary
            style="width: 700px;">
            <h1>SAMPLE DATA</h1>
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
    router.push({ name: 'index', query: { search: searchText.value } })
}
</script>

<style>
.v-navigation-drawer {
    background-color: rgba(19, 84, 122, .8);
    z-index: 2;
}
</style>
