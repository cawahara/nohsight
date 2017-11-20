document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('global-nav-vue')
   if(target_content != null){
      const parsed_data = JSON.parse(target_content.getAttribute('data'))

      let nav_items = document.getElementsByClassName('nav-item')
      for(let i = 0; i < nav_items.length; i++){
         let nav_item = nav_items[i]
         let nav_path = JSON.parse(nav_item.getAttribute('data')).path
         if(nav_path == parsed_data.path){
            nav_item.className= "nav-item active"
            nav_item.addEventListener('click', (e) => { e.preventDefault() })
            break
         }
      }
   }
})
