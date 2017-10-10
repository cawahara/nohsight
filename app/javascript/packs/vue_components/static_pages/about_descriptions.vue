<template>
   <div>
      <div class="section" v-for="article in articles">
         <h1 class="section-header">{{ article.header }}</h1>
         <div class="article" v-for="section in article.sections">
            <h2 class="article-header">{{ section.header }}</h2>
            <div v-for="content in section.contents">
               <p v-if="content.tag == 'p'">{{ content.resource }}</p>
               <img v-if="content.tag == 'img'" v-bind:src="content.resource">
            </div>
         </div>
      </div>
   </div>
</template>

<script>
   export default {
      props: ['values'],
      data: function(){
         return {
            articles: this.values
         }
      }
   }
</script>

<style scoped></style>
