class Area{
   constructor(value, tag_id){
      this.value = value
      this.tag_id = tag_id
   }
}

class Prefecture extends Area{
   constructor(value, tag_id){
      super(value, tag_id)
   }
}

var areas = {
             hokkaido:  new Area("北海道",   "hokkaido"),
             tohoku:    new Area("東北地方",   "tohoku"),
             kanto:     new Area("関東地方",   "kanto"),
             chubu:     new Area("中部地方",   "chubu"),
             kinki:     new Area("近畿地方", "kinki"),
             chugoku:   new Area("中国地方",   "chugoku"),
             shikoku:   new Area("四国地方",   "shikoku"),
             kyushu:    new Area("九州地方",   "kyushu")
            }

var hokkaido_prefs = [
                      new Prefecture("北海道", "hokkaido-hokkaido")
                     ]
var tohoku_prefs = [
                    new Prefecture("青森県", "tohoku-aomori"),
                    new Prefecture("岩手県", "tohoku-iwate"),
                    new Prefecture("宮城県", "tohoku-miyagi"),
                    new Prefecture("秋田県", "tohoku-akita"),
                    new Prefecture("山形県", "tohoku-yamagata"),
                    new Prefecture("福島県", "tohoku-fukushima")
                   ]
var kanto_prefs = [
                   new Prefecture("茨城県", "kanto-ibaraki"),
                   new Prefecture("栃木県", "kanto-tochigi"),
                   new Prefecture("群馬県", "kanto-gunma"),
                   new Prefecture("埼玉県", "kanto-saitama"),
                   new Prefecture("千葉県", "kanto-chiba"),
                   new Prefecture("東京都", "kanto-tokyo"),
                   new Prefecture("神奈川県", "kanto-kanagawa")
                  ]
var chubu_prefs = [
                   new Prefecture("山梨県", "chubu-yamanashi"),
                   new Prefecture("長野県", "chubu-nagano"),
                   new Prefecture("新潟県", "chubu-nigata"),
                   new Prefecture("富山県", "chubu-toyama"),
                   new Prefecture("石川県", "chubu-ishikawa"),
                   new Prefecture("福井県", "chubu-fukui"),
                   new Prefecture("岐阜県", "chubu-gifu"),
                   new Prefecture("静岡県", "chubu-shizuoka"),
                   new Prefecture("愛知県", "chubu-aichi")
                  ]
var kinki_prefs = [
                   new Prefecture("三重県", "kinki-mie"),
                   new Prefecture("滋賀県", "kinki-shiga"),
                   new Prefecture("京都府", "kinki-kyoto"),
                   new Prefecture("大阪府", "kinki-osaka"),
                   new Prefecture("兵庫県", "kinki-hyogo"),
                   new Prefecture("奈良県", "kinki-nara"),
                   new Prefecture("和歌山県", "kinki-wakayama")
                  ]
var chugoku_prefs = [
                      new Prefecture("鳥取県", "chugoku-tottori"),
                      new Prefecture("島根県", "chugoku-shimane"),
                      new Prefecture("岡山県", "chugoku-okayama"),
                      new Prefecture("広島県", "chugoku-hiroshima"),
                      new Prefecture("山口県", "chugoku-yamaguchi")
                     ]
var shikoku_prefs = [
                     new Prefecture("徳島県", "shikoku-tokushima"),
                     new Prefecture("香川県", "shikoku-kagawa"),
                     new Prefecture("愛媛県", "shikoku-ehime"),
                     new Prefecture("高知県", "shikoku-kochi")
                    ]
var kyushu_prefs = [
                    new Prefecture("福岡県", "kyushu-fukuoka"),
                    new Prefecture("佐賀県", "kyushu-saga"),
                    new Prefecture("長崎県", "kyushu-nagasaki"),
                    new Prefecture("熊本県", "kyushu-kumamoto"),
                    new Prefecture("大分県", "kyushu-oita"),
                    new Prefecture("宮崎県", "kyushu-miyazaki"),
                    new Prefecture("鹿児島県", "kyushu-kagoshima"),
                    new Prefecture("沖縄県", "kyushu-okinawa")
                   ]

var prefs = {
             hokkaido:  hokkaido_prefs,
             tohoku:    tohoku_prefs,
             kanto:     kanto_prefs,
             chubu:     chubu_prefs,
             kinki:     kinki_prefs,
             chugoku:   chugoku_prefs,
             shikoku:   shikoku_prefs,
             kyushu:    kyushu_prefs
            }

export default { areas, prefs }
