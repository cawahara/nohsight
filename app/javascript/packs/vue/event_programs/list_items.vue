<template>
   <div class="item-component" v-bind:class="mode">
      <input v-bind:name="getColumn(id, 'type')" type="hidden" v-bind:value="mode">
      <input v-bind:name="getColumn(id, 'id')" type="hidden" v-bind:value="ev_program.id">
      <div class="show-item" v-show="mode != 'update'">
         <p class="item-info">
            {{ ev_program.style }}
            {{ ev_program.genre }}
            「{{ program.title }}」
         </p>
         <ul class="item-performers">
            <li>演者： </li>
            <li v-for="ev_performer in ev_performers">{{ ev_performer.full_name }} </li>
         </ul>
      </div>
            <!--<program-index
               v-show="search_program.focus"
               :search_query="search_program.query"
               @return-value="setSearchValue"
            ></program-index> -->
      <div class="edit-item" v-show="mode == 'update'">
         <div class="lg-form">
            <label>演目</label>
            <div class="input-with-btn">
               <input v-bind:name="getColumn(id, 'title')" type="text" v-bind:value="program.title">
               <span class="btn"><i class="fa fa-bars"></i></span>
            </div>
         </div>

         <div class="sm-form">
            <label>種類</label>
            <input v-bind:name="getColumn(id, 'genre')" type="text" v-bind:value="ev_program.genre">
         </div>

         <div class="sm-form">
            <label>流派</label>
            <input v-bind:name="getColumn(id, 'style')" type="text" v-bind:value="ev_program.style">
         </div>

      </div>

      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
         <li v-on:click="changeClass('destroy')">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import Vue from 'vue'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            id:               this.values.id,
            ev_program:       this.values.ev_program,
            ev_performers:    this.values.ev_performers,
            program:          this.values.program,
            mode:             ''
         }
      },
      methods: {
         getColumn: function(id, name){
            return 'ev_program[' + id + '][' + name + ']'
         },
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
