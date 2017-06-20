<template>

   <div>
      <div class="nearby_location" v-for="location in locations">
         <img v-bind:src="location.thumbnail">
         <ul>
            <li>{{ location.title }}</li>
            <li><a v-bind:href="location.official_url" target="_blank">{{ location.official_url }}</a></li>
         </ul>
      </div>
      <div>
         <p class="no-event">{{ failed_msg }}</p>
      </div>
   </div>

</template>

<script>
   import * as $ from 'jquery'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            address:       this.values.ev_location,
            api_key:       process.env.GOOGLE_API_KEY,
            locations:     [],
            failed_msg:    ""
         }

      },
      created: function(){
         var self = this
         function failedMsg(msg){
            self.failed_msg = msg
         }
            // REVIEW: リクエストパラメータが適切でないとき対策： 建前は整っているが正規の方法とは言えない(例外処理の仕方がわからない)
            // TODO: 観光地のカテゴリ限定

            var map = new google.maps.Map(document.getElementById('map'), {})
            var service = new google.maps.places.PlacesService(map)

            function getDetailInfo(result, status){
               if(status == google.maps.places.PlacesServiceStatus.OK){
                  var title         = result.name
                  var thumbnail
                  if(result.hasOwnProperty('photos') == false){
                     thumbnail = 'https://www.massinsight.org/wp-content/uploads/2016/05/placeholder-4-351x246.png'
                  }else{
                     thumbnail = result.photos[0].getUrl({'maxWidth': 100, 'maxHeight': 100})
                  }
                  var official_url  = result.website
                  self.locations.push({
                                       title:        title,
                                       thumbnail:    thumbnail,
                                       official_url: official_url
                                    })
               }
            }

            function sendDetailReq(place_id){
               var request = { placeId: place_id }
               service.getDetails(request, getDetailInfo)
            }

            function getRelateInfo(results, status){
               if(status == google.maps.places.PlacesServiceStatus.OK){
                  var counter
                  if(results.length >= 3){
                     counter = 3
                  }else if(results.length > 0){
                     counter = results.length
                  }else{
                     return failedMsg("周辺スポットが見つかりませんでした。")
                  }
                  for(var i = 0; i < counter; i++){
                     var place_id = results[i].place_id
                     sendDetailReq(place_id)
                  }
               }
            }

            function sendRelateReq(geometry){
               var location = new google.maps.LatLng(geometry.latitude, geometry.longitude)
               var request = {
                  location: location,
                  radius: '2000',
                  query: '寺'
               }
               service.nearbySearch(request, getRelateInfo)
            }

            function getGeoInfo(data){
               if(data.results.length == 0){
                  return failedMsg('舞台の住所が有効ではありません')
               }
                  var latitude = data.results[0].geometry.location.lat
                  var longitude = data.results[0].geometry.location.lng
                  var geometry = { latitude: latitude, longitude: longitude }
                  sendRelateReq(geometry)
            }
            function sendGeoReq(address, api_key){

                  $.ajax({
                     url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&key=' + api_key,
                     type: 'GET',
                     dataType: 'json',
                     success: function(data){
                        getGeoInfo(data)
                     },
                     error: function(data){
                        console.log('An error occured')
                     }
                  })
            }
            sendGeoReq(this.address, this.api_key)
         }
      }

</script>

<style scoped></style>
