<template>
   <div>
      <div v-for="(ticket, idx) in tickets">
         <div class="item-component" v-bind:class="ticket.mode">
            <div class="show-item" v-show=" ticket.mode != 'update'">
               <p class="item-info">
                  {{ticket.grade}}:
                  {{ticket.price}}円
               </p>
            </div>

            <tickets-form
               v-show=" ticket.mode == 'update' "
               :ih_ticket="ticket"
            ></tickets-form>

            <ul class="item-icons">
               <li v-on:click="changeClass('update', idx)">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
               <li v-on:click="changeClass('destroy', idx)">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
            </ul>
         </div>
      </div>
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
            tickets:  this.values.tickets
         }
      },
      components: { 'tickets-form': tickets_form },
      methods: {
         changeClass: function(mode, idx){
            if(this.tickets[idx].mode == mode){
               this.tickets[idx].mode = ""
            }else{
               this.tickets[idx].mode = mode
            }
         }
      }
   }
</script>

<style scoped></style>
