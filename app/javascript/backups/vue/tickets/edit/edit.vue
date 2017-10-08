<template>
   <div>
      <div v-for="ticket in tickets">
         <tickets-item
            :ticket="ticket"
         ></tickets-item>
      </div>
   </div>
</template>

<script>
   import tickets_item from './_item.vue'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            tickets:  this.values.tickets
         }
      },
      components: { 'tickets-item': tickets_item }
   }
</script>

<style scoped></style>
