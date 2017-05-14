Event.seed do |s|
   s.id           = 1
   s.place_id     = 1
   s.user_id      = 1
   s.title        = "第28回　廣田鑑賞会能"
   s.start_date   = DateTime.new(2017, 5, 14, 13, 30)
   s.information  = "主役を勤める五流派（観世・宝生・金春・喜多・金剛）をシテ方といいます。
                     そのシテの相手役を務めるワキ方と、笛・小鼓・大鼓・太鼓を演奏する囃子方、
                     そして狂言方があります。シテとワキに連れられて出てくる役をツレ・ワキツレと呼びます。"
   s.official_url = "http://www.example.com/index.html"
end

Event.seed do |s|
   s.id           = 2
   s.place_id     = 2
   s.user_id      = 1
   s.title        = "京都観世会5月例会"
   s.start_date   = DateTime.new(2017, 5, 28, 11, 00)
   s.information  = ""
   s.official_url = "http://www.kanzei.com/5th-kai.html"
end

Event.seed do |s|
   s.id           = 3
   s.place_id     = 1
   s.user_id      = 2
   s.title        = "金剛定期能"
   s.start_date   = DateTime.new(2017, 5, 31, 13, 20)
   s.information  = "平成29年度の金剛定期能は年10回公演となります。
                     毎月、宗家以下総出演で佳曲を揃えました。 また上演前に演目の解説も行います。
                     29年度も多くの皆様にご鑑賞願いたく、絶大のご後援を賜ります様宜しくお願い申し上げます。
                     皆様のご入会を心よりお待ち申し上げております。
                     なお4月は特別公演として東本願寺能舞台にて開催いたします。"
   s.official_url = "http://www.example.com/regular.html"
end

Event.seed do |s|
   s.id           = 4
   s.place_id     = 2
   s.user_id      = 3
   s.title        = "市民狂言会"
   s.start_date   = DateTime.new(2017, 6, 9, 19, 00)
   s.information  = "KAC　Performing　Arts　Program　/　Contemporary　Danceでは、
                     京都芸術センターの創作環境を活かし、コンテンポラリーダンス表現の最前線で活躍する
                     振付家・ダンサーを迎えて新作の創作・上演および旧作の再創作を行う。"
   s.official_url = "http://www.kac.or.jp/program/9443/"
end

Event.seed do |s|
   s.id           = 5
   s.place_id     = 2
   s.user_id      = 1
   s.title        = "独立25周年記念 第16回 吉浪壽晃 能の会"
   s.start_date   = DateTime.new(2017, 6, 11, 13, 30)
   s.information  = ""
   s.official_url = "http://www.ecample.com/noh-no-kai.html"
end
