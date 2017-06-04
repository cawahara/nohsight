<template>
   <div class="item-component" v-bind:class="mode">
      <input v-bind:name="getItemId(id, 'type')" type="hidden" v-bind:value="mode">
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

      <div class="edit-item" v-show="mode == 'update'">
         <div class="sm-form">
            <label>演目</label>
            <input v-bind:name="getItemId(id, 'title')" type="text" v-bind:value="program.title">
         </div>
         <div class="sm-form">
            <label>ジャンル</label>
            <input v-bind:name="getItemId(id, 'genre')" type="text" v-bind:value="ev_program.genre">
         </div>
         <div class="sm-form">
            <label>流派</label>
            <input v-bind:name="getItemId(id, 'style')" type="text" v-bind:value="ev_program.style">
         </div>
         <div class="sm-form">
            <label>演者</label>
            <input v-bind:name="getItemId(id, 'performer')" type="text" v-bind:value="ev_performers[0].full_name">
         </div>
      </div>
      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<button><i class="fa fa-pencil"></i></button></li>
         <li v-on:click="changeClass('destroy')">削除<button><i class="fa fa-trash"></i></button></li>
      </ul>
   </div>
</template>

<script>

   module.exports = {
      props: [ 'values' ],
      data: function(){
         return {
            id:            this.values.id,
            ev_program:    this.values.ev_program,
            ev_performers: this.values.ev_performers,
            program:       this.values.program,
            mode:          ''
         }
      },
      methods: {
         getItemId: function(id, name){
            return 'ev_program[' + id + '][' + name + ']'
         },
         changeClass: function(mode){
            if(this.mode == mode)
               this.mode = ""
            else
               this.mode = mode
         }
      }
   }
</script>

<style scoped></style>
