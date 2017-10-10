<template>
   <div class="form-item">
      <div class="lg-form vertical-division">
         <label>演者：</label>
         <div class="vertical-section">
               <event-performers-form
                  v-for="ev_performer in ev_performers"
                  v-if="ev_performer.mode != 'create'"
                  :ev_program="ev_program"
                  :ev_performer="ev_performer"
                  :performers="performers"
               ></event-performers-form>

               <event-performers-new
                  :ev_program="ev_program"
                  :performers="performers"
                  :inherit_tag_id="tag_id"
                  :render_params="render_params"
               ></event-performers-new>
            </div>
         </div>
      </div>
   </div>
</template>

<script>
   import Vue from 'vue'
   import mixins from '../mixins.js'
   import event_performers_form from '../render/_form.vue'
   import event_performers_new from '../new/_new.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ev_program:    Object,
         ev_performers: Array,
         performers:    Array
      },
      data: function(){
         return {
            tag_id:  this.ev_performers.length,
            render_params: []
         }
      },
      components: { 'event-performers-form': event_performers_form,
                    'event-performers-new': event_performers_new },
      methods: { getColumn: mixins.getColumn },
      created: function(){

         for(var key in this.ev_performers){
            if(this.ev_performers[key].mode == 'create'){
               this.render_params.push(this.ev_performers[key].render_params)
            }

         }
      }
   }
</script>

<style scoped></style>
