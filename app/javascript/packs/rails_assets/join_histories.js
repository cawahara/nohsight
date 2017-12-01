import * as $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('join-histories-index')){

      let join_history_selector = document.querySelector('select')
      join_history_selector.addEventListener('change', (event) => {
         join_history_selector.form.submit()
      })
   }
})
