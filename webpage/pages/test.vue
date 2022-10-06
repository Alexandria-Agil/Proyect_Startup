<template>
    <br/><br/><br/>
    <div v-if="status">
        El Usuario Actual es {{username}}
    </div>


</template>

<script setup lang="ts">
    const Token = useCookie('Token')
    const value = Token.value
    const { data, refresh } = await useFetch<any>("/api/user",{headers: {"Authorization": value }} );
    const status = data.value.status
    const username = data.value.users[2][0]
    refresh();
</script>