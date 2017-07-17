<template>
   <dd>
      <input class="location-selection" readonly type="text" v-model:value="text_values" v-on:click="selector_activated = !selector_activated">
      <input name="search[locations]" type="hidden" v-model:value="hidden_values">
      <div class="search-location" v-show="selector_activated">
         <dl v-for="prefecture in prefectures">
            <dt>
               <input type="checkbox" v-bind:id="prefecture.tag_id" v-bind:value="prefecture.value" v-on:click="validateValue(prefecture)">
               <label v-bind:for="prefecture.tag_id">{{ prefecture.value }}</label>
            </dt>
            <dd v-for="area in areas[prefecture.tag_id]">
               <input type="checkbox" v-bind:id="area.tag_id" v-bind:class="prefecture.tag_id" v-bind:value="area.value" v-on:click="validateValue(area)">
               <label v-bind:for="area.tag_id">{{ area.value }}</label>
            </dd>
         </dl>
   </div>
   </dd>
</template>

<script>
   export default {
      props: ['values'],
      data: function(){
         return {
            prefectures: this.values.prefecture_values,
            areas: this.values.area_values,
            text_values: [],
            hidden_values: [],
            selector_activated: false
         }
      },
      methods: {
         isParent: function(location){
            if(location.constructor.name == "Prefecture"){
               return [location.value]
            }else{
               return location.cities
            }
         },
         writeValuesOnForms: function(location){
            this.text_values.push(location.value)
            this.hidden_values.push(this.isParent(location))
            this.hidden_values = Array.prototype.concat.apply([], this.hidden_values)
         },
         eraseValuesOnForms: function(location){
            var delete_idx = this.text_values.indexOf(location.value)
            if(delete_idx >= 0){
               this.text_values.splice(delete_idx, 1)
               if(location.constructor.name == "Prefecture"){
                  var delete_target = this.hidden_values.indexOf(location.value)
                  this.hidden_values.splice(delete_target, 1)
               }else{
                  var delete_target = this.hidden_values.indexOf(location.cities[0])
                  this.hidden_values.splice(delete_target, location.cities.length)
               }

            }
         },
         checkAllChildren: function(location, location_tag){
            if(location_tag.checked == true){
               for(var i = 0; i < this.areas[location.tag_id].length; i++){
                  this.eraseValuesOnForms(this.areas[location.tag_id][i])
               }
            }
            var children_tags = document.getElementsByClassName(location.tag_id)
            for(var i = 0; i < children_tags.length; i++){
               children_tags[i].checked = location_tag.checked
            }
         },
         checkRelatives: function(location, location_tag){
            if(location_tag.checked == false){
               var location_tag = document.getElementById(location.tag_id)
               var parent_tag = document.getElementById(location_tag.className)
               var delete_idx = this.text_values.indexOf(this.prefectures[parent_tag.id].value)
               this.eraseValuesOnForms(this.prefectures[parent_tag.id])
               if(delete_idx >= 0){
                  parent_tag.checked = false
                  for(var i = 0; i < this.areas[parent_tag.id].length; i++){
                     this.writeValuesOnForms(this.areas[parent_tag.id][i])
                  }
               }
            }
         },
         validateValue: function(location){
            var location_tag = document.getElementById(location.tag_id)

            if(location.constructor.name == "Prefecture"){
               this.checkAllChildren(location, location_tag)
            }else{
               this.checkRelatives(location, location_tag)
            }

            if(location_tag.checked == true){
               this.writeValuesOnForms(location)
            }else{
               this.eraseValuesOnForms(location)
            }
         }
      }
   }
</script>

<style scoped></style>
