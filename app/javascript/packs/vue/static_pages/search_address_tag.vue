<template>
   <dd>
      <input id="locations" readonly type="text" v-bind:name="search" v-model:value="text_values">
      <div id="locations-selection" v-show="selector_activated">
         <dl v-for="area in areas">
            <dt>
               <input type="checkbox" v-bind:id="area.tag_id" v-bind:value="area.value" v-on:click="checkValue(area)">
               <label v-bind:for="area.tag_id">{{ area.value }}</label>
            </dt>
            <dd v-for="pref in prefs[area.tag_id]">
               <input type="checkbox" v-bind:id="pref.tag_id" v-bind:class="area.tag_id" v-bind:value="pref.value" v-on:click="checkValue(pref)">
               <label v-bind:for="pref.tag_id">{{ pref.value }}</label>
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
            areas: this.values.areas,
            prefs: this.values.prefectures,
            text_values: [],
            selector_activated: false,
            search:  this.values.search_type + '[locations]'
         }
      },
      methods: {
         toggleSelector: function(event){
            var input_tag = document.getElementById('locations')
            var selector_tag = document.getElementById('locations-selection')
            if(event.target == input_tag){
               this.selector_activated = !this.selector_activated
            }else if(!selector_tag.contains(event.target)){
               this.selector_activated = false
            }
         },
         checkValue: function(location){
            var location_tag = document.getElementById(location.tag_id)

            if(location.constructor.name == "Area"){
               this.checkAllChildren(location_tag)
            }else{
               this.validateAreaValue(location_tag)
               this.attrTextValue(location_tag)
            }
         },
         checkAllChildren: function(location_tag){
            var command = location_tag.checked
            var children_tags = document.getElementsByClassName(location_tag.id)
            for(var i = 0; i < children_tags.length; i++){
               children_tags[i].checked = command
               this.attrTextValue(children_tags[i])
            }
         },
         attrTextValue: function(location_tag){
            var delete_idx = this.text_values.indexOf(location_tag.value)
            if(delete_idx >= 0){
               this.text_values.splice(delete_idx, 1)
            }
            if(location_tag.checked == true){
               this.text_values.push(location_tag.value)
            }
         },
         validateAreaValue: function(location_tag){
            if (location_tag.checked == false){
               var parent_tag = document.getElementById(location_tag.className)
               parent_tag.checked = false
            }
         }
      },
      created: function(){
         window.addEventListener('click', this.toggleSelector)
      }
   }
</script>

<style scoped></style>
