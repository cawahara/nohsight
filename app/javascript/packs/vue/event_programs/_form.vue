<template>
   <div class="form-item">
      <input v-bind:name="getColumn(id, 'type')" type="hidden" v-model:value="inherit_mode">
      <input v-bind:name="getColumn(id, 'id')" type="hidden" v-bind:value="ev_program.id">
      <div class="lg-form">
         <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
         <label>演目</label>
         <div class="input-with-btn">
            <input v-bind:name="getColumn(id, 'title')" type="text" v-bind:value="program.title">
            <span v-bind:class="{ active: programs_edit_component }" class="btn" v-on:click="toggleComponent()"><i class="fa fa-bars"></i></span>
         </div>
      </div>

      <programs-edit
         v-show="programs_edit_component == true"
         :inherit_id="id"
         :inherit_program="program"
         :inherit_place="place"
      ></programs-edit>

      <div class="sm-form">
         <label>種類</label>
         <input v-bind:name="getColumn(id, 'genre')" type="text" v-bind:value="ev_program.genre">
      </div>

      <div class="sm-form">
         <label>流派</label>
         <input v-bind:name="getColumn(id, 'style')" type="text" v-bind:value="ev_program.style">
      </div>

   </div>

</template>

<script>
   import mixins from './mixins.js'
   import programs_edit from '../programs/_form.vue'
   export default {
      mixins: [ mixins ],
      props: {
         inherit_id:         Number,
         inherit_ev_program: Object,
         inherit_program:    Object,
         inherit_place:      Object,
         inherit_mode:       String
      },
      data: function(){
         return {
            id:                       this.inherit_id,
            ev_program:               this.inherit_ev_program,
            program:                  this.inherit_program,
            place:                    this.inherit_place,
            programs_edit_component:  false
         }
      },
      components: { 'programs-edit': programs_edit },
      methods: {
         toggleComponent: function(){
            if(this.programs_edit_component == false){
               this.programs_edit_component = true
            }else{
               this.programs_edit_component = false
            }
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
