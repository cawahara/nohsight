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
         <div class="program-form">
            <label>演目</label>
            <input v-bind:name="getColumn(id, 'title')" type="text" v-model:value="search_program.query"
            v-focus="search_program.focus" v-focus.lazy="true" @focus="search_program.focus = true">
            <span class="btn"><i class="fa fa-bars"></i></span>
         </div>

         <div class="program-sm-form">
            <label>種類</label>
            <input v-bind:name="getColumn(id, 'genre')" type="text" v-bind:value="ev_program.genre">
         </div>
         <div class="program-sm-form">
            <label>流派</label>
            <input v-bind:name="getColumn(id, 'style')" type="text" v-bind:value="ev_program.style">
         </div>

         <!-- TODO: Event-performerディレクトリを作成 => 編集用Vueコンポーネントを作成 -->
         <div class="performer-form">
            <label>演者</label>
            <div class="performer-form-content">
               <div class="performer-form-header">
                  <input v-bind:name="getColumn(id, 'performer')" type="text" v-bind:value="ev_performers[0].full_name">
                  <ul class="item-icons">
                     <li><span class="btn"><i class="fa fa-pencil"></i></span></li>
                     <li><span class="btn"><i class="fa fa-trash"></i></span></li>
                  </ul>
               </div>
            </div>
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
   import program_index from '../programs/_index.vue'
   import { focus } from 'vue-focus'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            id:               this.values.id,
            ev_program:       this.values.ev_program,
            ev_performers:    this.values.ev_performers,
            program:          this.values.program,
            mode:             '',
            search_program:   { query: this.values.program.title, focus: false },   // 初期値を「演目」にすることで編集と演目候補の検索を併用
         }
      },
      components: { 'program-index': program_index },
      directives: { 'focus': focus },
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
            this.search_program.query = this.values.program.title
         },
         setSearchValue: function(return_msg){
               this.search_program.query = return_msg
               this.search_program.focus = false
         }
      }
   }
</script>

<style scoped>

</style>
