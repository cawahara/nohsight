<template>
   <div class="item-component" v-bind:class="mode">
      <div class="show-item" v-show="mode != 'update'">
         <p class="item-info">
            {{ticket.grade}}:
            {{ticket.price}}円
         </p>
      </div>

      <tickets-form
         v-show=" mode == 'update' "
         :inherit_mode="mode"
         :inherit_id="id"
         :inherit_ticket="ticket"

      ></tickets-form>

      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
         <li v-on:click="changeClass('destroy')">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import mixins from './mixins.js'
   import tickets_form from './_form.vue'
   export default {
      props: [ 'values' ],
      mixins: [ mixins ],
      data: function(){
         return {
            id:           this.values.id,
            ticket:       this.values.ticket,
            mode:         ''
         }
      },
      components: { 'tickets-form': tickets_form },
      methods: {
         changeClass: function(mode){
            if(this.mode == mode){
               this.mode = ""
            }else{
               this.mode = mode
            }
         }
      }
   }
</script>

<style scoped></style>
