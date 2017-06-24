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
   s.published    = true
end

Event.seed do |s|
   s.id           = 2
   s.place_id     = 2
   s.user_id      = 1
   s.title        = "京都観世会5月例会"
   s.start_date   = DateTime.new(2017, 5, 28, 11, 00)
   s.information  = ""
   s.official_url = "http://www.kanzei.com/5th-kai.html"
   s.published    = true
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
   s.published    = true
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
   s.published    = true
end

Event.seed do |s|
   s.id           = 5
   s.place_id     = 2
   s.user_id      = 1
   s.title        = "独立25周年記念 第16回 吉浪壽晃 能の会"
   s.start_date   = DateTime.new(2017, 6, 11, 13, 30)
   s.information  = ""
   s.official_url = "http://www.ecample.com/noh-no-kai.html"
   s.published    = true
end

Event.seed do |s|
   s.id           = 6
   s.place_id     = 1
   s.user_id      = 2
   s.title        = "県民のための能を知る会"
   s.start_date   = DateTime.new(2017, 6, 25, 16, 00)
   s.information  = ""
   s.official_url = "http://www.nohbutai.com/"
   s.published    = true
end

Event.seed do |s|
   s.id           = 7
   s.place_id     = 6
   s.user_id      = 1
   s.title        = "金春会定期能"
   s.start_date   = DateTime.new(2017, 7, 1, 17, 00)
   s.information  = ""
   s.official_url = ""
   s.published    = true
end

Event.seed do |s|
   s.id           = 8
   s.place_id     = 10
   s.user_id      = 2
   s.title        = "演能の会　高崎公演　レクチャー"
   s.start_date   = DateTime.new(2017, 7, 8, 11, 20)
   s.information  = "当社（難波八阪神社）の創建年月日など詳しい資料は残っていませんが、社伝によれば古来「
                     難波下の宮」と称し難波一帯の産土神でした。後三条天皇の延久（1069年から1073年）の頃から祇園牛頭天王（ごずてんのう）を
                     お祀りする古社として世間に知られていました。
　                   もとは神仏混淆でしたが、維新後、神仏分離により寺は廃絶し、明治5年(1872年)に郷社となりました。
                     現在のご本殿は、昭和49年（1974年）5月に完成。
　                   毎年１月の第３日曜日に行われている綱引神事は当社の御祭神、素盞嗚尊（すさのをのみこと）が八岐大蛇（やまたのおろち）を退治し、
                     民衆の困苦を除かれた故事に基づき始められたと言われています。「摂津名所図絵」や「摂津名所図会大成」にも紹介されています。また、平成13年(2001年)には、大阪市で初めての無形民俗文化財に指定されました。"
   s.official_url = "http://www.takasaki-foundation.or.jp/gallery/moyoosi.html"
   s.published    = true
end

Event.seed do |s|
   s.id           = 9
   s.place_id     = 1
   s.user_id      = 3
   s.title        = "志の輔らくご at NOH THEATER"
   s.start_date   = DateTime.new(2017, 7, 11, 13, 30)
   s.information  = "銀座六丁目に居を移し、新たな歴史を刻み始めた観世能楽堂で初の落語会を銀座花鏡開幕記念公演としてお届けします。
                     日本の伝統文化の真髄を伝える劇場で、立川志の輔による新たな幕が開きます。
                     志の輔らくごで、こころ揺さぶられるひとときをお楽しみください。"
   s.official_url = ""
   s.published    = true
end

Event.seed do |s|
   s.id           = 10
   s.place_id     = 24
   s.user_id      = 3
   s.title        = "シア能楽公演 金剛流による能「羽衣」を上演「樂―茶碗の中の宇宙展」開催記念"
   s.start_date   = DateTime.new(2017, 7, 25, 13, 30)
   s.information  = "650 年の歴史を持つ能楽界において五流のうち四流の宗家が東京を本拠地とする中で、京都に宗家が存在する唯一の流儀である金剛流。
                     サンクトペテルブルクの公演では 、二十六世宗家・金剛永謹師の監修・出演による 「羽衣」をはじめ、重厚かつ華やかな舞台を披露し 、
                     日本が誇る伝統芸能の魅力をお届けします。"
   s.official_url = ""
   s.published    = true
end

Event.seed do |s|
   s.id           = 11
   s.place_id     = 1
   s.user_id      = 2
   s.title        = "お豆腐の和らい「都の賑わい」京都公演"
   s.start_date   = DateTime.new(2017, 7, 30, 9, 10)
   s.information  = "毎年恒例の、茂山千五郎家・クラブSOJA企画のお楽しみ狂言会「お豆腐の和らい（わらい）」
                     今年は「都の賑わい」と題しまして、茂山千五郎家が本家を構える京都にまつわる三演目を上演致します。
                     色鮮やかな変化に富んだ都の面白さ、可笑しさをどうぞお楽しみくださいませ。"
   s.official_url = "http://kyotokyogen.com/schedule/20170505waraikyoto/"
   s.published    = true
end

Event.seed do |s|
   s.id           = 12
   s.place_id     = 2
   s.user_id      = 1
   s.title        = "水無月狂言の集い"
   s.start_date   = DateTime.new(2017, 8, 3, 21, 30)
   s.information  = ""
   s.official_url = "http://kyotokyogen.com/schedule/20170624minazuki/"
   s.published    = true
end

Event.seed do |s|
   s.id           = 13
   s.place_id     = 90
   s.user_id      = 1
   s.title        = "伝統芸能　狂言を楽しむ会"
   s.start_date   = DateTime.new(2017, 8, 4, 9, 30)
   s.information  = ""
   s.official_url = "http://kyotokyogen.com/schedule/20170709kagoshima/"
   s.published    = true
end

Event.seed do |s|
   s.id           = 14
   s.place_id     = 2
   s.user_id      = 3
   s.title        = "第2回加西能"
   s.start_date   = DateTime.new(2017, 8, 13, 13, 15)
   s.information  = "新作能『針間」は哲学者梅原猛さんの書き下ろしによるもので、2人の皇子（意奚と袁奚）が
                     皇位継承争いの続く都から志染の里（現三木市）に逃れて、それぞれ牛飼いと馬飼いになり、
                     後に都で仁賢天皇と顕宗天皇になった話を描いています。
                     『高砂』には観世銕之丞さんら、『針間』には人間国宝の大槻文蔵さんら能楽師の一線級がそろい、
                     観客らは美しい舞に酔いしれ、延べ約1時間半の上演が終わると、会場は大きな拍手に包まれた。
                     大槻さんは「（2年前と比べて）今回はホールだったので凝縮した感じで一体感があった。また機会があれば演じたい」と話されました。"
   s.official_url = "http://www.fudoki1300.city.kasai.hyogo.jp/nou/kasainou2/"
   s.published    = true
end

Event.seed do |s|
   s.id           = 15
   s.place_id     = 2
   s.user_id      = 2
   s.title        = "井上同門定期能楽会"
   s.start_date   = DateTime.new(2017, 8, 13, 19, 30)
   s.information  = "当初、「薪御能」は、舞台が野外の芝生であったため、紙を敷き踏んで芝の状態を見たとされています。
                     現在は、敷き舞台の上で行う為、その必要はありませんが、芝の湿り具合いで能のあるなしを決めていたことを今に伝えるため、
                     演能の前に興福寺衆徒（僧兵）により「舞台あらため」が行われます。
                     また、その結果を人々に伝えるために「外僉義（げのせんぎ）」文が読み上げられます。
                     外僉義文は、寺の外部の人達に向けて僉義を発表するものです。
                     これらの儀式は他では見ることのできない「薪御能」だけの特色です。"
   s.official_url = "https://narashikanko.or.jp/event/takigiono/"
   s.published    = true
end

Event.seed do |s|
   s.id           = 16
   s.place_id     = 12
   s.user_id      = 2
   s.title        = "大槻能楽堂自主公演能　能の魅力を探るシリーズ－能と和歌－"
   s.start_date   = DateTime.new(2017, 8, 24, 11, 00)
   s.information  = ""
   s.official_url = "http://www.noh-kyogen.com/schedule/2017/05.html"
   s.published    = true
end

Event.seed do |s|
   s.id           = 17
   s.place_id     = 1
   s.user_id      = 1
   s.title        = "第二回 風の能"
   s.start_date   = DateTime.new(2017, 9, 1, 12, 15)
   s.information  = ""
   s.official_url = "http://www.susumushingu.com/news.shtml"
   s.published    = true
end

Event.seed do |s|
   s.id           = 18
   s.place_id     = 210
   s.user_id      = 1
   s.title        = "おうみ狂言図鑑 2017"
   s.start_date   = DateTime.new(2017, 9, 3, 13, 00)
   s.information  = "ニンジャカジャと大名、そしてちょっとタロウカジャ"
   s.official_url = ""
   s.published    = true
end

Event.seed do |s|
   s.id           = 19
   s.place_id     = 17
   s.user_id      = 3
   s.title        = "財団設立20周年記念　第209回公演　いばらき能「安達原」"
   s.start_date   = DateTime.new(2017, 9, 5, 13, 40)
   s.information  = "解説つきで能の全曲をお楽しみいただける「いばらき能」。
                     昨年度の「葵上」に続き、鬼女をテーマとした能「安達原」をお送りします。"
   s.official_url = "http://www.ibabun.jp/eventLeaf.php?eid=00267"
   s.published    = true
end

Event.seed do |s|
   s.id           = 20
   s.place_id     = 19
   s.user_id      = 2
   s.title        = "河村定期研能会"
   s.start_date   = DateTime.new(2017, 9, 20, 10, 10)
   s.information  = "※ゆかた（その他和装）でお越しの方を対象に7月25日「天神祭能船」の乗船券など豪華景品が当たる抽選会をご用意しています！ "
   s.official_url = ""
   s.published    = true
end
