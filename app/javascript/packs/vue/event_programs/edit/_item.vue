<template>
   <div class="item-component" v-bind:class="ev_program.mode">
      <div class="show-item" v-show="ev_program.mode != 'update'">
         <p class="item-info">
            {{ ev_program.style }}
            {{ ev_program.genre }}
            「{{ ev_program.title }}」
         </p>
         <ul class="item-performers">
            <li>演者： </li>
            <li v-for="ev_performer in ev_performers">{{ ev_performer.full_name }} </li>
         </ul>
      </div>

      <event-programs-form
         v-show="ev_program.mode == 'update'"
         :ev_program="ev_program"
         :programs="programs"
      ></event-programs-form>

      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
         <li v-on:click="changeClass('destroy')">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import mixins from '../mixins.js'
   import event_programs_form from '../render/_form.vue'
   export default {
      props: {
         ev_program:    Object,
         ev_performers: Array,
         programs:      Array
      },
      mixins: [ mixins ],
      components: { 'event-programs-form': event_programs_form },
      methods: {
         changeClass: function(mode){
            if(this.ev_program.mode == mode){
               this.ev_program.mode = ""
            }else{
               this.ev_program.mode = mode
            }
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
