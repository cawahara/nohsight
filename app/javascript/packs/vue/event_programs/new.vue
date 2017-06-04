<template>
   <div>
      <div id="new-items">
         <div class="form-for-mount"></div>
      </div>
      <ul class="item-icons">
         <li v-on:click="addNewItem()">演目の追加<span class="btn"><i class="fa fa-plus"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import Vue from 'vue'
   import render_form from './_form.vue'

   export default {
      data: function(){
         return {
            values: { id: 0 }
         }
      },
      components: {
         'render-form': render_form
      },
      methods: {
         addNewItem: function(){
            new Vue({
               el: '.form-for-mount',
               data: { values: { id: this.values.id } },
               render(h){ return h(render_form, { props: { values: this.values }}) }
            })
            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-items').appendChild(node)
            this.values.id += 1
         }
      }
   }
</script>

<style scoped></style>
