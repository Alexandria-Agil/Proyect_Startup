<template>
    <v-layout color="grey-lighten-3">
        <v-app-bar color="teal-darken-4" image="https://iili.io/snGjtf.jpg">
            <template v-slot:image>
                <v-img gradient="to top right, rgba(19,84,122,.8), rgba(128,208,199,.8)"></v-img>
            </template>

            <template v-slot:prepend>
                <v-app-bar-nav-icon @click="drawer_active($event)"></v-app-bar-nav-icon>
            </template>

            <v-app-bar-title>Alexandria Archives</v-app-bar-title>

            <v-spacer></v-spacer>

            <v-btn style="border: 1px solid #000; margin-right: 10px;" to="/signin">
                Sign In
            </v-btn>

            <v-text-field class="input" hide-details label="Search Snow" placeholder="Search"
                rounded dense single-line>
            </v-text-field>

            <v-btn icon>
                <v-icon>mdi-magnify</v-icon>
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
//const navDrawer = ref<HTMLDivElement>(null);

function drawer_active(event): void {
    drawer.value = !(drawer.value)
}
</script>

<style>
.v-navigation-drawer {
    background-color: rgba(19, 84, 122, .8);
    z-index: 2;
}
</style>
