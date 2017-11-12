<template>
   <dd>
      <input id="category" readonly type="hidden" name="search[category]" v-model:value="text_values">
      <ul id="category-selection">
         <li v-for="(category, idx) in categories"><input v-bind:id="'category-' + idx" type="checkbox" v-on:click="attrTextValue(idx)"><label>{{ category }}</label></li>
      </ul>
   </dd>
</template>

<script>
   export default {
      props: ['values'],
      data: function(){
         return {
            text_values: new Array(),
            categories: this.values.categories
         }
      },
      methods: {
         attrTextValue: function(idx){
            var category_tag = document.getElementById('category-' + idx)
            var delete_idx = this.text_values.indexOf(idx)
            if(delete_idx >= 0){
               this.text_values.splice(delete_idx, 1)
            }
            if(category_tag.checked == true){
               this.text_values.push(idx)
            }
         },
      }
   }
</script>

<style scoped></style>
