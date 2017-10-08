<template>
   <div>
      <div v-for="(ev_program, idx) in ev_programs">
         <event-programs-item
            :ev_program="ev_program"
            :ev_performers="ev_performers[idx]"
            :programs="programs"
         ></event-programs-item>
      </div>
   </div>
</template>

<script>
   import mixins from '../mixins.js'
   import event_programs_item from './_item.vue'
   export default {
      props: [ 'values' ],
      mixins: [ mixins ],
      data: function(){
         return {
            ev_programs:    this.values.event_programs,
            ev_performers:  this.values.event_performers,
            programs:       this.values.programs
         }
      },
      components: { 'event-programs-item': event_programs_item }
   }
</script>

<style scoped></style>
