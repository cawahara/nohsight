<template>
   <div>
      <div class="form-pointer"></div>
      <div class="form-item sub-form place-form">
         <h3 class="form-header">■演目舞台の詳細情報</h3>
         <div class="lg-form">
            <label>住所</label>
            <input v-bind:name="getColumn(id, 'address')" type="text" v-bind:value="place.address">
         </div>

         <div class="lg-form">
            <label>サイトURL</label>
            <input v-bind:name="getColumn(id, 'official_url')" type="text" v-bind:value="place.official_url">
         </div>

      </div>
   </div>
</template>

<script>
   import mixins from '../event_programs/mixins.js'
   export default {
      props: {
         inherit_id:         Number,
         inherit_place:      Object
      },
      data: function(){
         return {
            id:     this.inherit_id,
            place:   this.inherit_place
         }
      },
      methods: {
         getColumn: mixins.getColumn
      }
   }

</script>

<style scoped></style>
