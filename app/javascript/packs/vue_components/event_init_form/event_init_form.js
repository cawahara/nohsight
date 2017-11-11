import Vue from 'vue'
import {EventPerformer, EventProgram, Ticket} from './event_data_attributes.js'

document.addEventListener('DOMContentLoaded', () => {
   // REVIEW: Androidはじめ、スマホ環境下では下記エラーが発生してしまう
   //         Uncaught TypeError: Object.values is not a function
   const node = document.querySelector('#event-init-form-vue')
   if(node != null){

      function objectToValues(objs) {
         let arr = new Array()
         for(let key in objs){
            arr.push(objs[key])
         }
         return arr
      }

      function readOnlyonDestroy(data, type){
         for(let key in data){
            if(data[key].mode == 'destroy'){
               let input_forms = document.querySelectorAll('#' + type + '_' + key + '> .md-form input[type=text]')
               for(let form_key in input_forms){
                  if(form_key == 'length'){
                     continue
                  }
                  input_forms[form_key].readOnly = true
               }
            }
         }
      }

      function changeMode(data, type, key, mode){
         let input_forms = document.querySelectorAll('#' + type + '_' + key + '> .md-form input[type=text]')
         let read_only
         if(mode == 'destroy'){
            read_only = true
         }else{
            read_only = false
         }
         for(let form_key in input_forms){
            if(form_key == 'length'){
               continue
            }
            input_forms[form_key].readOnly = read_only
         }
         data[key].mode = mode
      }

      function hasErrorMsgs(target, key){
         if(typeof target !== 'undefined' && typeof target[key] !== 'undefined'){
            return true
         }else{
            return false
         }
      }

      let parsed_data = JSON.parse(node.getAttribute('data'))
      if(parsed_data.event.publishing_status == null){
         parsed_data.event.publishing_status = 0
      }

         // Datas for event basical information
         let form_event_vue = new Vue({
            el: '#form-event-vue',
            data: function(){
               return {
                  values:     parsed_data.event,
                  error_msgs: parsed_data.error_msgs.event
               }
            }
         })

         // Datas for event's place information
         let form_place_vue = new Vue({
            el: '#form-place-vue',
            data: function(){
               return {
                  values:     parsed_data.place,
                  error_msgs: parsed_data.error_msgs.place
               }
            }
         })

         let event_programs_data = objectToValues(parsed_data.event_programs)
         // Datas for evetn_programs information
         let form_event_programs_vue = new Vue({
            el: '#form-event-programs-vue',
            data: function(){
               return {
                  values:     event_programs_data,
                  error_msgs: parsed_data.error_msgs.event_programs
               }
            },
            methods: {
               changeMode: function(key, mode){
                  changeMode(this.values, 'event_program', key, mode)
               },
               createNewComponent: function(){
                  let last_idx = this.values.length
                  this.values.push(new EventProgram())
                  this.$nextTick(function(){
                     newEventPerformerVue(last_idx.toString())
                  })

               },
               deleteNewComponent: function(key){
                  this.$delete(this.values, key)
               },
               hasErrorMsgs: function(key){
                  return hasErrorMsgs(this.error_msgs, key)
               }
            },
            mounted: function(){
               readOnlyonDestroy(this.values, 'event_program')
            }
         })

         function newEventPerformerVue(key){
            let event_performers_data = objectToValues(event_programs_data[key].event_performers)
            new Vue({
               el: '#form-event-performers-vue-' + key,
               data: function(){
                  return {
                     program_key:  key,
                     values:       event_performers_data,
                     error_msgs:   parsed_data.error_msgs.event_programs
                  }
               },
               methods: {
                  changeMode: function(key, mode){
                     changeMode(this.values, 'event_program_' + this.program_key + '_event_performer', key, mode)
                  },
                  createNewComponent: function(){
                     this.values.push(new EventPerformer())
                  },
                  deleteNewComponent: function(key){
                     this.$delete(this.values, key)
                  },
                  hasErrorMsgs: function(program_key, performer_key){
                     if(hasErrorMsgs(this.error_msgs, program_key) == true &&
                        hasErrorMsgs(this.error_msgs[program_key].event_performers, performer_key) == true){
                        return true
                     }else{
                        return false
                     }
                  }
               },
               mounted: function(){
                  readOnlyonDestroy(this.values, 'event_program_' + key + '_event_performer')
               }
            })
         }

         for(let key in event_programs_data){
            newEventPerformerVue(key.toString())
         }

         let tickets_data = objectToValues(parsed_data.tickets)
         let form_tickets_vue = new Vue({
            el: '#form-tickets-vue',
            data: function(){
               return {
                  values:     tickets_data,
                  error_msgs: parsed_data.error_msgs.tickets
               }
            },
            methods: {
               changeMode: function(key, mode){
                  changeMode(this.values, 'ticket', key, mode)
               },
               createNewComponent: function(){
                  this.values.push(new Ticket())
               },
               deleteNewComponent: function(key){
                  this.$delete(this.values, key)
               },
               hasErrorMsgs: function(key){
                  return hasErrorMsgs(this.error_msgs, key)
               }
            },
            mounted: function(){
               readOnlyonDestroy(this.values, 'ticket')
            }
         })
   }
})
