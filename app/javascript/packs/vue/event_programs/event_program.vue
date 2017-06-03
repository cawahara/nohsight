<template>
   <div class="item-component" v-bind:class="mode">
      <p class="item-info">
         {{ ev_program.style }}
         {{ ev_program.genre }}
         「{{ program.title }}」
      </p>
      <ul class="item-performers">
         <li>演者： </li>
         <li v-for="ev_performer in ev_performers">{{ ev_performer.full_name }} </li>
      </ul>
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
            ev_program:    this.values.ev_program,
            ev_performers: this.values.ev_performers,
            program:       this.values.program,
            mode:          ''
         }
      },
      methods: {
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
