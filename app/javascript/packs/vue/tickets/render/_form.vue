<template>
   <div v-bind:id="getTagId(mode, tag_id)" class="form-item">
      <input v-bind:name="getColumn(tag_id, 'mode')" type="hidden" v-model:value="ticket.mode">
      <input v-bind:name="getColumn(tag_id, 'id')" type="hidden" v-bind:value="id">
      <input v-bind:name="getColumn(tag_id, 'event_id')" type="hidden" v-bind:value="event_id">
      <div class="sm-form">
         <label>客席</label>
         <input v-bind:id="getColumn(tag_id, 'grade')"
         v-bind:name="getColumn(tag_id, 'grade')" type="text" v-bind:value="grade">
      </div>

      <div class="sm-form">
         <label>料金</label>
         <input v-bind:id="getColumn(tag_id, 'price')"
         v-bind:name="getColumn(tag_id, 'price')" type="text" v-bind:value="price">
      </div>

      <ul v-if=" mode == 'create' " class="item-icons">
         <li v-on:click="deleteNewItem(tag_id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
      </ul>
   </div>

</template>

<script>
   import mixins from '../mixins.js'
   export default {
      mixins: [ mixins ],
      props: {
         ticket:   Object,
      },
      data: function(){
         return {
            id:         this.ticket.id,
            mode:       this.ticket.mode,
            tag_id:     this.ticket.tag_id,
            event_id:   this.ticket.event_id,
            grade:      this.ticket.grade,
            price:      this.ticket.price
         }
      },
      methods: {
         getTagId: function(mode, id){
            return mode + '-' + id
         },
         deleteNewItem: function(id){
            var el = document.getElementById('create-' + id)
            el.parentNode.removeChild(el)
         },
         getColumn: mixins.getColumn
      },
      mounted: function(){
         if(this.ticket.render_params != false){
            this.grade = this.ticket.render_params.grade
            this.price = this.ticket.render_params.price
            var input_columns = { grade: this.ticket.render_params.grade,
                                  price: this.ticket.render_params.price }
            for(var key in input_columns){
               var input_tag = document.getElementById(this.getColumn(this.tag_id, key))
               if(input_columns[key].length == 0){
                  input_tag.className = 'field_with_errors'
               }else if(key == 'price' && /[^0-9]+/.test(input_columns[key]) == true){
                  input_tag.className = 'field_with_errors'
               }
            }
         }
      }
   }
</script>

<style scoped></style>
