module EventsHelper

   def first_program(event)
      program = event.event_programs.first.program
      return program
   end

   # Location周辺のスポット情報を取得
   def get_nearby_locations(location)

      # Locationの住所を緯度・経度に変換
      geo_api_uri = URI.parse(URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{location.address}&key=#{ENV['GOOGLE_API_KEY']}").to_s)
      geo_json = JSON.parse(Net::HTTP.get(geo_api_uri))
      geo_info = {
                  "latitude"  => geo_json["results"][0]["geometry"]["location"]["lat"].to_s,
                  "longitude" => geo_json["results"][0]["geometry"]["location"]["lng"].to_s
                  }

      # 緯度・経度を基に周辺スポットを3つまで取得
      place_api_uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geo_info['latitude']},#{geo_info['longitude']}&radius=500&keyword=temple&key=#{ENV['GOOGLE_API_KEY']}")
      place_json = JSON.parse(Net::HTTP.get(place_api_uri))

      # Google Custom Search API でurlと最初の説明のみ入手
      rec_places = []
      3.times do |n|
         place_title = place_json['results'][n]['name']
         if place_title != nil
            place_thumbnail = Net::HTTP.get(URI.parse("https://maps.googleapis.com/maps/api/place/photo?photoreference=#{place_json['results'][n]['photos'][0]['photo_reference']}&key=#{ENV['GOOGLE_API_KEY']}"))
            place_url = JSON.parse(Net::HTTP.get(URI.parse("https://maps.googleapis.com/maps/api/place/details/json?&reference=#{place_json['results'][n]['reference']}&key=#{ENV['GOOGLE_API_KEY']}")))
            rec_place = {
                         "title" => place_title,
                         "thumbnail" => place_thumbnail,
                         "official_url" => place_url['result']['website']
                        }
            rec_places << rec_place
         end
      end

      return rec_places

   end
end
