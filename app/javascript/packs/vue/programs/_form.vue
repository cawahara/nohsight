<template>
   <div class="form-item program-form">

      <ul class="list-form">
         <li class="with-category">
            <label>曲目</label>
            <input v-bind:name="getColumn(id, 'category')" type="text" v-bind:value="program.category">
         </li>
         <li class="with-duration">
            <label>公演時間</label>
            <input v-bind:name="getColumn(id, 'duration')" type="text" v-bind:value="program.duration">
         </li>
         <li class="with-shimai">
            <label>仕舞</label>
            <input v-bind:name="getColumn(id, 'shimai')" type="checkbox" v-bind:value="program.shimai"
             v-bind:true-value="true" v-bind:false-value="false">
         </li>
      </ul>

      <div class="lg-form">
         <label>舞台</label>
         <div class="input-with-btn">
            <input v-bind:name="getColumn(id, 'place')" type="text" v-bind:value="place.title">
            <span v-bind:class="{ active: places_edit_component }" class="btn" v-on:click="toggleComponent()"><i class="fa fa-map-marker"></i></span>
         </div>
      </div>

      <places-edit
         v-show="places_edit_component == true"
         :inherit_id="id"
         :inherit_place="place"
      ></places-edit>

   </div>
</template>

<script>
   import mixins from '../event_programs/mixins.js'
   import places_edit from '../places/_form.vue'
   export default {
      props: {
         inherit_id:         Number,
         inherit_program:    Object,
         inherit_place:      Object
      },
      data: function(){
         return {
            id:                     this.inherit_id,
            program:                this.inherit_program,
            place:                  this.inherit_place,
            places_edit_component:   false
         }
      },
      components: { 'places-edit': places_edit },
      methods: {
         toggleComponent: function(){
            if(this.places_edit_component == false){
               this.places_edit_component = true
            }else{
               this.places_edit_component = false
            }
         },
         getColumn: mixins.getColumn
      }
   }

</script>

<style scoped></style>
