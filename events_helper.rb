module EventsHelper

   def first_program(event)
      program = event.event_programs.first.program
      return program
   end

   # Location周辺のスポット情報を取得
   def get_nearby_locations(location)
      begin
         # Locationの住所を緯度・経度に変換
         geo_api_uri = URI.parse(URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{location.address}&key=#{ENV['GOOGLE_API_KEY']}").to_s)
         geo_json = JSON.parse(Net::HTTP.get(geo_api_uri))
         geo_info = {
                     "latitude"  => geo_json["results"][0]["geometry"]["location"]["lat"].to_s,
                     "longitude" => geo_json["results"][0]["geometry"]["location"]["lng"].to_s
                     }

         # 緯度・経度を基に周辺スポットを3つまで取得
         # REVIEW 周辺スポットをnearbysearchクエリで探しているが、指定スポットから何m以内の範囲に絞るか(現在は師弟スポットから10000m以内の周辺スポットを探索)
         place_api_uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{geo_info['latitude']},#{geo_info['longitude']}&radius=10000&keyword=temple&language=ja&key=#{ENV['GOOGLE_API_KEY']}")
         place_json = JSON.parse(Net::HTTP.get(place_api_uri))

         # Google Custom Search API でurlを入手
         rec_places = []
         3.times do |n|
            place_title = place_json['results'][n]['name']
            if place_title != nil
               # FIXME 機能するが、コードが汚すぎる(主にGETリクエスト時のURLが冗長)短める必要性あり
               place_thumbnail = Net::HTTP.get(URI.parse("https://maps.googleapis.com/maps/api/place/photo?&sensor=false&maxwidth=80&maxheight=80&photoreference=#{place_json['results'][n]['photos'][0]['photo_reference']}&key=#{ENV['GOOGLE_API_KEY']}"))
                  # FIXME 上記のリクエストだとページそのものにリダイレクトし、画像を引き出せない
                  place_thumbnail = place_thumbnail.scan(/https:\/\/lh3\.googleusercontent.com.+"/).to_s.gsub(/"|\[|\]|\\/, '')
               place_url = JSON.parse(Net::HTTP.get(URI.parse("https://maps.googleapis.com/maps/api/place/details/json?&reference=#{place_json['results'][n]['reference']}&language=ja&key=#{ENV['GOOGLE_API_KEY']}")))
               rec_place = {
                            "title" => place_title,
                            "thumbnail" => place_thumbnail,
                            "official_url" => place_url['result']['website']
                           }
               rec_places << rec_place
            end
         end

         return rec_places
      rescue NoMethodError
         return nil
      end
   end
end
