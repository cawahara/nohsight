<template>
   <div>
      <div class="item-component" v-bind:class="mode">
         <input v-bind:name="getColumn('event_program', tag_id, 'id')" type="hidden" v-model:value="id">
         <input v-bind:name="getColumn('event_program', tag_id, 'mode')" type="hidden" v-model:value="mode">
         <div class="show-item">
            <p class="item-info">
               {{ style }}
               {{ genre }}
               「{{ title }}」
            </p>
            <ul class="item-performers" v-show="mode != 'update'">
               <li>演者： </li>
               <li v-for="ev_performer in ev_performers">{{ ev_performer.full_name }} </li>
            </ul>
         </div>

         <div class="edit-item">
            <event-performers-edit
               v-show="mode == 'update'"
               :ev_program="ev_program"
               :ev_performers="ev_performers"
               :performers="performers"
            ></event-performers-edit>

         </div>
         <ul class="item-icons">
            <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
         </ul>
      </div>
   </div>
</template>

<script>
   import event_performers_edit from './_edit.vue'
   import mixins from '../mixins.js'
   export default {
      mixins: [ mixins ],
      props: {
         ev_program:    Object,
         ev_performers: Array,
         performers:    Array
      },
      data: function(){
         return {
            id:         this.ev_program.id,
            tag_id:     this.ev_program.tag_id,
            mode:       this.ev_program.mode,
            style:      this.ev_program.style,
            genre:      this.ev_program.genre,
            title:      this.ev_program.title,
         }
      },
      components: { 'event-performers-edit': event_performers_edit },
      methods: {
         changeClass: function(mode){
            if(this.mode == mode){
               this.mode = ""
            }else{
               this.mode = mode
            }
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped>

</style>
