
import Vue from 'vue'
import * as $ from 'jquery'
import SearchAddress from './search_address_tag.vue'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('search')
   if(target_content != null){

      class Prefecture{
         constructor(value, tag_id){
            this.value = value
            this.tag_id = tag_id
         }
      }

      class Area extends Prefecture{
         constructor(value, tag_id, cities){
            super(value, tag_id)
            this.cities = cities
         }
      }

      var prefecture_values = {
                               shiga:    new Prefecture("滋賀県",   "shiga"),
                               kyoto:    new Prefecture("京都府",   "kyoto"),
                               osaka:    new Prefecture("大阪府",   "osaka"),
                               mie:      new Prefecture("三重県",   "mie"),
                               wakayama: new Prefecture("和歌山県", "wakayama"),
                               hyogo:    new Prefecture("兵庫県",   "hyogo"),
                               nara:     new Prefecture("奈良県",   "nara"),
                              }

      var shiga_area_values = [
                               new Area("大津", "shiga-otsu", ["大津市"]),
                               new Area("南部", "shiga-nanbu", ["草津市", "守山市", "栗東市", "野洲市"]),
                               new Area("甲賀", "shiga-koga", ["甲賀市", "湖南市"]),
                               new Area("東近江", "shiga-higashiomi", ["東近江市", "近江八幡市", "日野町", "竜王町"]),
                               new Area("湖東", "shiga-koto", ["彦根市", "愛荘町", "豊郷町", "甲良町", "多賀町"]),
                               new Area("湖北", "shiga-kohoku", ["米原市", "長浜市"]),
                               new Area("高島", "shiga-takashima", ["高島市"])
                              ]
      var kyoto_area_values = [
                               new Area("京都市", "kyoto-kyoto", ["京都市"]),
                               new Area("丹後", "kyoto-tango", ["京丹後市", "宮津市", "舞鶴市", "伊根町", "与謝野町"]),
                               new Area("丹波", "kyoto-tanba", ["福知山市", "綾部市", "南丹市", "亀岡市", "京丹波町"]),
                               new Area("山城", "kyoto-yamagi", ["長岡京市", "向日市", "久御山市", "宇治市", "宇治田原町", "和束町", "南山城村", "笠置町", "木津川市", "精華町", "京田辺市", "井出町", "常陽市", "八幡市", "大山崎市"]),
                              ]
      var osaka_area_values = [
                               new Area("大阪市", "osaka-osaka", ["大阪市"]),
                               new Area("豊能", "osaka-toyono", ["豊中市", "池田市", "箕面市", "豊能郡"]),
                               new Area("三島", "osaka-mishima", ["高槻市", "吹田市", "茨木市", "摂津市", "三島郡"]),
                               new Area("泉北", "osaka-senboku", ["堺市", "泉大津市", "和泉市", "高石市", "和泉北郡"]),
                               new Area("泉南", "osaka-sennan", ["岸和田市", "貝塚市", "泉佐野市", "泉南市", "阪南市", "泉南郡"]),
                               new Area("北河内", "osaka-kitakawachi", ["枚方市", "寝屋川市", "守口市", "大東市", "門真市", "四条畷市", "交野市"]),
                               new Area("中河内", "osaka-nakakawachi", ["東大阪市", "八尾市", "柏原市"]),
                               new Area("南河内", "osaka-minamikawachi", ["富田林氏", "河内長野市", "松原市", "羽曳野市", "藤井寺市", "大阪狭山市", "南河内郡"]),
                              ]
      var mie_area_values = [
                               new Area("北勢", "mie-hokusei", ["桑名郡", "桑名市", "員弁郡", "いなべ市", "四日市市", "三重郡", "鈴鹿市", "亀山市"]),
                               new Area("伊賀", "mie-iga", ["伊賀市", "名張市"]),
                               new Area("中勢", "mie-chusei", ["津市", "松坂氏", "多気郡"]),
                               new Area("南勢", "mie-kyoto", ["伊勢市", "宇羽市", "志摩市", "度会郡"]),
                               new Area("東紀州", "mie-nansei", ["尾鷲市", "熊野市", "北牟婁郡", "南牟婁郡"])
                              ]
      var wakayama_area_values = [
                               new Area("海草", "wakayama-kaiso", ["和歌山市", "海南市", "海草郡"]),
                               new Area("那賀", "wakayama-naga", ["紀の川市", "岩出市"]),
                               new Area("伊都", "wakayama-ito", ["橋本市", "伊都郡"]),
                               new Area("有田", "wakayama-arida", ["有田市", "有田郡"]),
                               new Area("日高", "wakayama-hidaka", ["御坊市", "日高郡"]),
                               new Area("西牟婁", "wakayama-nishimuro", ["田邊市", "西牟婁郡"]),
                               new Area("東牟婁", "wakayama-higashimuro", ["新宮市", "東牟婁郡"])
                              ]
      var hyogo_area_values = [
                               new Area("但馬", "hyogo-tanma", ["豊岡市", "楊阜氏", "朝来市", "美方郡"]),
                               new Area("丹波", "hyogo-tanba", ["篠山市", "丹波市"]),
                               new Area("阪神南", "hyogo-hanshinminami", ["尼崎市", "西宮氏", "芦屋市"]),
                               new Area("阪神北", "hyogo-hanshinkita", ["伊丹市", "宝塚市", "川西市", "三田氏", "川辺郡"]),
                               new Area("神戸", "hyogo-kobe", ["神戸市"]),
                               new Area("東播磨", "hyogo-higashiharima", ["明石市", "加古川市", "高砂市", "加古郡"]),
                               new Area("北播磨", "hyogo-kitaharima", ["西脇市", "三木市", "小野市", "加西市", "加東市", "多可郡"]),
                               new Area("中播磨", "hyogo-nakaharima", ["姫路市", "川崎郡"]),
                               new Area("西播磨", "hyogo-nishiharima", ["相生市", "たつの市", "赤穂市", "宍粟市", "揖保郡", "赤穂郡", "佐用郡"]),
                               new Area("淡路", "hyogo-awaji", ["洲本市", "南あわじ市", "淡路市"])
                              ]
      var nara_area_values = [
                               new Area("北和", "nara-hokuwa", ["奈良市", "生駒市", "大和郡", "天理市", "山辺郡"]),
                               new Area("西和", "nara-nishiwa", ["生駒郡", "北葛城郡"]),
                               new Area("中和", "nara-nakawa", ["磯城郡", "香芝市", "葛城市", "大和高田市", "橿原市", "桜井市"]),
                               new Area("南和", "nara-nanwa", ["御所市", "高市郡", "五條市", "吉野郡"]),
                               new Area("宇陀", "nara-uda", ["宇陀市", "宇陀郡"]),
                               new Area("吉野", "nara-yoshino", ["吉野郡"])
                              ]

      var area_values = {
                         shiga:    shiga_area_values,
                         kyoto:    kyoto_area_values,
                         osaka:    osaka_area_values,
                         mie:      mie_area_values,
                         wakayama: wakayama_area_values,
                         hyogo:    hyogo_area_values,
                         nara:     nara_area_values
                        }

      const node = document.getElementById('search-address-vue')
      var search_values = { prefecture_values: prefecture_values, area_values: area_values }
      var seatch_address_item = new Vue({
         el: '#search-address-vue',
         render(h){
            return h(SearchAddress, { props: { values: search_values }})
         }
      })
   }
})
