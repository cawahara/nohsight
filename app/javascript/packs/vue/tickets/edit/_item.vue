<template>
   <div class="item-component" v-bind:class="ticket.mode">
      <div class="show-item" v-show=" ticket.mode != 'update'">
         <p class="item-info">
            {{ grade }}:
            {{ price }}円
         </p>
      </div>

      <tickets-form
         v-show=" ticket.mode == 'update' "
         :ticket="ticket"
      ></tickets-form>

      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
         <li v-on:click="changeClass('destroy')">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import tickets_form from '../render/_form.vue'
   export default {
      props: {
         ticket: Object
      },
      data: function(){
         return {
            grade: this.ticket.grade,
            price: this.ticket.price
         }
      },
      components: { 'tickets-form': tickets_form },
      methods: {
         changeClass: function(mode, idx){
            if(this.ticket.mode == mode){
               this.ticket.mode = ""
            }else{
               this.ticket.mode = mode
            }
         }
      }
   }
</script>

<style scoped></style>
