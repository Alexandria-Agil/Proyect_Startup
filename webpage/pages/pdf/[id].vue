<template>
    <br/><br/><br/>
    <h1>
        {{route.params.id}}
    </h1>
    <embed src="https://www.africau.edu/images/default/sample.pdf" width="500" height="500" 
 type="application/pdf">
</template>

<script setup lang="ts">
    const route = useRoute();
</script>