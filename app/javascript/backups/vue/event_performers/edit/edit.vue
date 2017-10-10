<template>
   <div>
      <div v-for="(ev_program, idx) in ev_programs">
         <event-performers-item
            :ev_program="ev_program"
            :ev_performers="ev_performers[idx]"
            :performers="performers"
         ></event-performers-item>
      </div>
   </div>
</template>

<script>
   import event_performers_item from './_item.vue'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            ev_programs:   this.values.event_programs,
            ev_performers: this.values.event_performers,
            performers:    this.values.performers
         }
      },
      components: { 'event-performers-item': event_performers_item }
   }
</script>

<style scoped>

</style>
