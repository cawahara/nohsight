# frozen_string_literal: true

# FIXME: 重複データの削除、idの欠番を抑える
Place.seed do |s|
   s.id = 1
   s.title = '六角堂頂法寺'
   s.address = '日本, 〒604-8134 京都府京都市中京区六角通東洞院西入堂之前町'
   s.official_url = 'http://www.ikenobo.jp/rokkakudo'
end

Place.seed do |s|
   s.id = 2
   s.title = '革堂行願寺'
   s.address = '日本, 〒604-0991 京都府京都市中京区行願寺門前町 寺町通竹屋町上る行願寺門前町17'
end

Place.seed do |s|
   s.id = 3
   s.title = '壬生寺'
   s.address = '日本, 〒604-8821 京都府京都市中京区中京区壬生梛ノ宮町３１'
   s.official_url = 'http://www.mibudera.com/'
end

Place.seed do |s|
   s.id = 4
   s.title = '本能寺'
   s.address = '日本, 〒604-8243 京都府京都市中京区本能寺町'
end

Place.seed do |s|
   s.id = 5
   s.title = '大報恩寺'
   s.address = '日本, 〒602-8319 京都府京都市上京区溝前町 七本松通今出川上ル溝前町1034番地'
   s.official_url = 'http://www.daihoonji.com/'
end

Place.seed do |s|
   s.id = 6
   s.title = '清浄華院'
   s.address = '日本, 〒602-0852 京都府京都市上京区北之辺町 京都府京都市上京区寺町通広小路上る北之辺町395'
   s.official_url = 'http://www.jozan.jp/'
end

Place.seed do |s|
   s.id = 7
   s.title = '相国寺'
   s.address = '日本, 〒602-0898 京都府京都市上京区相国寺門前町 今出川通烏丸東入'
   s.official_url = 'http://www.shokoku-ji.jp/'
end

Place.seed do |s|
   s.id = 8
   s.title = '引接寺'
   s.address = '日本, 〒602-8307 京都府京都市上京区閻魔前町 千本通蘆山寺上ル閻魔前町３４'
   s.official_url = 'http://yenmado.blogspot.jp/'
end

Place.seed do |s|
   s.id = 9
   s.title = '報恩寺'
   s.address = '日本, 〒620-0002 京都府福知山市報恩寺'
end

Place.seed do |s|
   s.id = 10
   s.title = '東本願寺'
   s.address = '日本, 〒600-8505 京都府京都市下京区常葉町 烏丸通七条上る'
   s.official_url = 'http://www.higashihonganji.or.jp/'
end

Place.seed do |s|
   s.id = 11
   s.title = '西本願寺'
   s.address = '日本, 〒060-0003 北海道札幌市中央区北3条西１９丁目１９'
   s.official_url = 'http://www.hongwanji.or.jp/'
end

Place.seed do |s|
   s.id = 12
   s.title = '六波羅蜜寺'
   s.address = '日本, 〒605-0933 京都府京都市東山区轆轤町 五条通大和大路上ル東'
   s.official_url = 'http://rokuhara.or.jp/'
end

Place.seed do |s|
   s.id = 13
   s.title = '清水寺'
   s.address = '日本, 〒605-0862 京都府京都市東山区清水１丁目２９４'
   s.official_url = 'http://www.kiyomizudera.or.jp/'
end

Place.seed do |s|
   s.id = 14
   s.title = '知恩院'
   s.address = '日本, 〒605-8686 京都府京都市東山区林下町４００'
   s.official_url = 'http://www.chion-in.or.jp/index.php'
end

Place.seed do |s|
   s.id = 15
   s.title = '泉涌寺'
   s.address = '日本, 〒605-0977 京都府京都市東山区泉涌寺山内町２７'
   s.official_url = 'http://www.mitera.org/'
end

Place.seed do |s|
   s.id = 16
   s.title = '今熊野観音寺'
   s.address = '日本, 〒605-0977 京都府京都市東山区泉涌寺山内町３２'
   s.official_url = 'http://www.kannon.jp/'
end

Place.seed do |s|
   s.id = 17
   s.title = '方広寺'
   s.address = '日本, 〒431-2224 静岡県浜松市北区引佐町奥山１５７７−１'
   s.official_url = 'http://www.houkouji.or.jp/'
end

Place.seed do |s|
   s.id = 18
   s.title = '三十三間堂'
   s.address = '日本, 〒605-0941 京都府京都市東山区三十三間堂廻リ６５７'
   s.official_url = 'http://www.sanjusangendo.jp/'
end

Place.seed do |s|
   s.id = 19
   s.title = '東福寺'
   s.address = '日本, 〒605-0981 京都府京都市東山区本町15−778'
   s.official_url = 'http://www.tofukuji.jp/'
end

Place.seed do |s|
   s.id = 20
   s.title = '大雲院'
   s.address = '日本, 〒605-0074 京都府京都市東山区祇園町南側５９４−１'
end

Place.seed do |s|
   s.id = 21
   s.title = '建仁寺'
   s.address = '日本, 〒605-0811 京都府京都市東山区小松町 大和大路通四条下る小松町584'
   s.official_url = 'http://www.kenninji.jp/'
end

Place.seed do |s|
   s.id = 22
   s.title = '南禅寺'
   s.address = '日本, 〒606-8435 京都府京都市左京区南禅寺福地町'
   s.official_url = 'http://www.nanzen.net/'
end

Place.seed do |s|
   s.id = 23
   s.title = '慈照寺'
   s.address = '日本, 〒606-8402 京都府京都市左京区銀閣寺町２'
   s.official_url = 'http://www.shokoku-ji.jp/g_about.html'
end

Place.seed do |s|
   s.id = 24
   s.title = '鞍馬寺'
   s.address = '日本, 〒601-1111 京都府京都市左京区鞍馬本町1074番地'
   s.official_url = 'http://www.kuramadera.or.jp/'
end

Place.seed do |s|
   s.id = 25
   s.title = '三千院'
   s.address = '日本, 〒601-1242 京都府京都市左京区大原来迎院町５４０'
   s.official_url = 'http://www.sanzenin.or.jp/'
end

Place.seed do |s|
   s.id = 26
   s.title = '寂光院'
   s.address = '日本, 〒601-1248 京都府京都市左京区大原草生町６７６'
   s.official_url = 'http://www.jakkoin.jp/'
end

Place.seed do |s|
   s.id = 27
   s.title = '知恩寺'
   s.address = '日本, 〒606-8225 京都府京都市左京区田中門前町103'
   s.official_url = 'http://hyakusan.jp/'
end

Place.seed do |s|
   s.id = 28
   s.title = '禅林寺'
   s.address = '日本, 〒606-8445 京都府京都市左京区永観堂町48'
   s.official_url = 'http://www.eikando.or.jp/'
end

Place.seed do |s|
   s.id = 29
   s.title = '瑠璃光院'
   s.address = '日本, 〒601-1255 京都府京都市左京区上高野東山５５'
   s.official_url = 'http://rurikoin.komyoji.com/'
end

Place.seed do |s|
   s.id = 30
   s.title = '天竜寺'
   s.address = '日本, 〒616-8385 京都府京都市右京区嵯峨天龍寺芒ノ馬場町 嵯峨天龍寺芒ノ馬場町68'
   s.official_url = 'http://www.tenryuji.com/'
end

Place.seed do |s|
   s.id = 31
   s.title = '妙心寺'
   s.address = '日本, 〒616-8035 京都府京都市右京区花園妙心寺町64'
   s.official_url = 'http://www.myoshinji.or.jp/'
end

Place.seed do |s|
   s.id = 32
   s.title = '化野念仏寺'
   s.address = '日本, 〒616-8436 京都府京都市右京区嵯峨鳥居本化野町１７'
   s.official_url = 'http://www.nenbutsuji.jp/'
end

Place.seed do |s|
   s.id = 33
   s.title = '愛宕念仏寺'
   s.address = '日本, 〒616-8439 京都府京都市右京区嵯峨鳥居本深谷町２−５'
   s.official_url = 'http://www.otagiji.com/'
end

Place.seed do |s|
   s.id = 34
   s.title = '竜安寺'
   s.address = '日本, 〒616-8001 京都府京都市右京区龍安寺御陵ノ下町１３'
   s.official_url = 'http://www.ryoanji.jp/'
end

Place.seed do |s|
   s.id = 35
   s.title = '仁和寺'
   s.address = '日本, 〒616-8092 京都府京都市右京区御室大内３３'
   s.official_url = 'http://www.ninnaji.or.jp/'
end

Place.seed do |s|
   s.id = 36
   s.title = '神護寺'
   s.address = '日本, 〒616-8292 京都府京都市右京区梅ケ畑高雄町５'
   s.official_url = 'http://www.jingoji.or.jp/'
end

Place.seed do |s|
   s.id = 37
   s.title = '高山寺'
   s.address = '日本, 〒616-8295 京都府京都市右京区梅ケ畑栂尾町8'
   s.official_url = 'http://www.kosanji.com/'
end

Place.seed do |s|
   s.id = 38
   s.title = '等持院'
   s.address = '日本, 〒603-8346 京都府京都市北区等持院北町６３'
end

Place.seed do |s|
   s.id = 39
   s.title = '鹿苑寺'
   s.address = '日本, 〒603-8361 京都府京都市北区金閣寺町１'
   s.official_url = 'http://www.shokoku-ji.jp/k_access.html'
end

Place.seed do |s|
   s.id = 40
   s.title = '大徳寺'
   s.address = '日本, 〒603-8231 京都府京都市北区紫野大徳寺町５３'
   s.official_url = 'http://www.rinnou.net/cont_03/07daitoku/'
end

Place.seed do |s|
   s.id = 41
   s.title = '西芳寺'
   s.address = '日本, 〒615-8286 京都府京都市西京区松尾神ケ谷町５６'
   s.official_url = 'http://www.pref.kyoto.jp/isan/saihouji.html'
end

Place.seed do |s|
   s.id = 42
   s.title = '善峯寺'
   s.address = '日本, 〒610-1133 京都府京都市西京区大原野小塩町1372'
   s.official_url = 'http://www.yoshiminedera.com/'
end

Place.seed do |s|
   s.id = 43
   s.title = '平等院'
   s.address = '日本, 〒611-0021 京都府宇治市宇治蓮華１１６'
   s.official_url = 'http://www.byodoin.or.jp/'
end

Place.seed do |s|
   s.id = 44
   s.title = '三室戸寺'
   s.address = '日本, 〒611-0013 京都府宇治市莵道滋賀谷２１'
   s.official_url = 'http://www.mimurotoji.com/'
end

Place.seed do |s|
   s.id = 45
   s.title = '興聖寺'
   s.address = '日本, 〒611-0021 京都府宇治市宇治山田２７−１'
   s.official_url = 'http://kyoto-uji-kankou.or.jp/others/corse/shot/index.html'
end

Place.seed do |s|
   s.id = 46
   s.title = '神応寺'
   s.address = '日本, 〒614-8007 京都府八幡市八幡西高坊２４'
   s.official_url = 'http://www.city.yawata.kyoto.jp/0000000490.html'
end

Place.seed do |s|
   s.id = 47
   s.title = '一休寺'
   s.address = '日本, 〒610-0341 京都府京田辺市薪里ノ内 京都府京田辺市薪里ノ内102'
   s.official_url = 'http://www.ikkyuji.org/'
end

Place.seed do |s|
   s.id = 48
   s.title = '岩船寺'
   s.address = '日本, 〒619-1133 京都府木津川市加茂町岩船上ノ門４３'
   s.official_url = 'http://0774.or.jp/temple/gansenji.html'
end

Place.seed do |s|
   s.id = 49
   s.title = '浄瑠璃寺'
   s.address = '日本, 〒619-1135 京都府木津川市加茂町西小札場札場40'
   s.official_url = 'http://0774.or.jp/temple/jyoruriji.html'
end

Place.seed do |s|
   s.id = 50
   s.title = '海住山寺'
   s.address = '日本, 〒619-1106 京都府木津川市加茂町例幣海住山境外２０'
   s.official_url = 'http://www.kaijyusenji.jp/'
end

Place.seed do |s|
   s.id = 51
   s.title = '笠置寺'
   s.address = '日本, 〒619-1303 京都府相楽郡笠置笠置山 笠置町笠置笠置山29'
   s.official_url = 'http://www.kasagidera.or.jp/'
end

Place.seed do |s|
   s.id = 52
   s.title = '金胎寺'
   s.address = '日本, 〒619-1202 京都府相楽郡和束町原山鷲峰山 京都府相楽郡和束町原山鷲峰山'
end

Place.seed do |s|
   s.id = 53
   s.title = '宝積寺'
   s.address = '日本, 〒329-1233 栃木県塩谷郡高根沢町宝積寺'
end

Place.seed do |s|
   s.id = 54
   s.title = '穴太寺'
   s.address = '日本, 〒621-0029 京都府亀岡市曽我部町穴太東ノ辻４６'
   s.official_url = 'http://saikoku33.gr.jp/21/'
end

Place.seed do |s|
   s.id = 55
   s.title = '成相寺'
   s.address = '日本, 〒629-2241 京都府宮津市成相寺３３９'
   s.official_url = 'http://www.nariaiji.jp/'
end

Place.seed do |s|
   s.id = 56
   s.title = '智恩寺'
   s.address = '日本, 〒626-0001 京都府宮津市文珠４６６'
   s.official_url = 'http://www.monjudo-chionji.jp/'
end

Place.seed do |s|
   s.id = 57
   s.title = '松尾寺'
   s.address = '日本, 〒639-1057 奈良県大和郡山市山田町６８３'
   s.official_url = 'http://www.matsuodera.com/'
end

Place.seed do |s|
   s.id = 58
   s.title = '能福寺'
   s.address = '日本, 〒652-0837 兵庫県神戸市兵庫区北逆瀬川町１−３９'
   s.official_url = 'http://nofukuji.jp/'
end

Place.seed do |s|
   s.id = 59
   s.title = '須磨寺'
   s.address = '日本, 〒654-0071 兵庫県神戸市須磨区須磨寺町'
end

Place.seed do |s|
   s.id = 60
   s.title = '忉利天上寺'
   s.address = '日本, 〒657-0105 兵庫県神戸市灘区摩耶山町２−１２'
   s.official_url = 'http://www.mayasan-tenjoji.jp/'
end

Place.seed do |s|
   s.id = 61
   s.title = '中山寺'
   s.address = '日本, 〒665-0861 兵庫県宝塚市中山寺'
end

Place.seed do |s|
   s.id = 62
   s.title = '清荒神清澄寺'
   s.address = '日本, 〒665-0837 兵庫県宝塚市米谷清シ−１'
   s.official_url = 'http://www.kiyoshikojin.or.jp/'
end

Place.seed do |s|
   s.id = 63
   s.title = '神呪寺'
   s.address = '日本, 〒662-0001 兵庫県西宮市甲山町２５−１'
   s.official_url = 'http://www.ne.jp/asahi/kabutoyama/kanno-ji/'
end

Place.seed do |s|
   s.id = 64
   s.title = '鷲林寺'
   s.address = '日本, 〒662-0003 兵庫県西宮市鷲林寺町４−８'
   s.official_url = 'http://www5b.biglobe.ne.jp/~jurinji/'
end

Place.seed do |s|
   s.id = 65
   s.title = '高源寺'
   s.address = '日本, 〒669-3821 兵庫県丹波市青垣町桧倉５１４'
   s.official_url = 'http://kougenji-tanba.or.jp/'
end

Place.seed do |s|
   s.id = 66
   s.title = '圓満寺'
   s.address = '日本, 〒675-0157 兵庫県加古郡播磨町上野添２丁目１'
   s.official_url = 'http://www.enmanji.net/'
end

Place.seed do |s|
   s.id = 67
   s.title = '鶴林寺'
   s.address = '日本, 〒675-0031 兵庫県加古川市加古川町北在家北在家４２４'
   s.official_url = 'http://www.kakurinji.or.jp/'
end

Place.seed do |s|
   s.id = 68
   s.title = '教信寺'
   s.address = '日本, 〒675-0012 兵庫県加古川市野口町野口４６５'
   s.official_url = 'http://www.bekkoame.ne.jp/~housenin/link32.html'
end

Place.seed do |s|
   s.id = 69
   s.title = '播州清水寺'
   s.address = '日本, 〒673-1402 兵庫県加東市平木１１９４'
   s.official_url = 'http://kiyomizudera.net/'
end

Place.seed do |s|
   s.id = 70
   s.title = '光明寺'
   s.address = '日本, 〒491-0135 愛知県一宮市光明寺'
end

Place.seed do |s|
   s.id = 71
   s.title = '浄土寺'
   s.address = '日本, 〒722-0043 広島県尾道市東久保町20−28'
   s.official_url = 'http://www.ermjp.com/j/temple/'
end

Place.seed do |s|
   s.id = 72
   s.title = '一乗寺'
   s.address = '日本, 〒606-8115 京都府京都市左京区一乗寺里ノ西町102'
end

Place.seed do |s|
   s.id = 73
   s.title = '随願寺'
   s.address = '日本, 〒670-0808 兵庫県姫路市白国５'
end

Place.seed do |s|
   s.id = 74
   s.title = '圓教寺'
   s.address = '日本, 〒671-2201 兵庫県姫路市書写２９６８'
   s.official_url = 'http://www.shosha.or.jp/'
end

Place.seed do |s|
   s.id = 75
   s.title = '八葉寺'
   s.address = '日本, 〒969-3422 福島県会津若松市河東町広野冬木沢 福島県会津若松市河東町広野冬木沢'
end

Place.seed do |s|
   s.id = 76
   s.title = '花岳寺'
   s.address = '日本, 〒678-0239 兵庫県赤穂市加里屋１９９２'
   s.official_url = 'https://kagakuji.jimdo.com/'
end

Place.seed do |s|
   s.id = 77
   s.title = '太融寺'
   s.address = '日本, 〒530-0051 大阪府大阪市北区太融寺町'
end

Place.seed do |s|
   s.id = 78
   s.title = '鶴満寺'
   s.address = '日本, 〒531-0063 大阪府大阪市北区長柄東１丁目３−１２'
end

Place.seed do |s|
   s.id = 79
   s.title = '三津寺'
   s.address = '日本, 〒542-0085 大阪府大阪市中央区心斎橋筋２丁目７−１２'
   s.official_url = 'https://mitsutera.jp/'
end

Place.seed do |s|
   s.id = 80
   s.title = '北御堂'
   s.address = '日本, 〒541-0053 大阪府大阪市中央区本町４丁目4−1−3'
   s.official_url = 'http://www.kitamido.or.jp/'
end

Place.seed do |s|
   s.id = 81
   s.title = '南御堂'
   s.address = '日本, 〒541-0056 大阪府大阪市中央区久太郎町４丁目１−１１'
   s.official_url = 'http://minamimido.jp/'
end

Place.seed do |s|
   s.id = 82
   s.title = '法善寺'
   s.address = '日本, 〒542-0076 大阪府大阪市中央区難波１丁目１−２−１６'
   s.official_url = 'http://houzenji.jp/'
end

Place.seed do |s|
   s.id = 83
   s.title = '四天王寺'
   s.address = '日本, 〒543-0051 大阪府大阪市天王寺区四天王寺'
end

Place.seed do |s|
   s.id = 84
   s.title = '勝鬘院'
   s.address = '日本, 〒543-0075 大阪府大阪市天王寺区夕陽丘町５−３６'
   s.official_url = 'http://www.aizendo.com/'
end

Place.seed do |s|
   s.id = 85
   s.title = '円珠庵'
   s.address = '日本, 〒543-0018 大阪府大阪市天王寺区空清町４−２'
   s.official_url = 'http://kamahachiman.sakura.ne.jp/'
end

Place.seed do |s|
   s.id = 86
   s.title = '道善寺'
   s.address = '日本, 〒543-0071 大阪府大阪市天王寺区生玉町２−６'
end

Place.seed do |s|
   s.id = 87
   s.title = '大念佛寺'
   s.address = '日本, 〒547-0045 大阪府大阪市平野区平野上町１丁目７−２６'
   s.official_url = 'http://www.dainenbutsuji.com/'
end

Place.seed do |s|
   s.id = 88
   s.title = '勝尾寺'
   s.address = '日本, 〒562-0021 大阪府箕面市粟生間谷２９１４−１'
   s.official_url = 'http://www.katsuo-ji-temple.or.jp/'
end

Place.seed do |s|
   s.id = 89
   s.title = '成田山明王院'
   s.address = '日本, 〒572-0005 大阪府寝屋川市成田西町１０−１'
   s.official_url = 'http://www.osaka-naritasan.or.jp/'
end

Place.seed do |s|
   s.id = 90
   s.title = '慈眼寺'
   s.address = '日本, 〒891-0146 鹿児島県鹿児島市慈眼寺町'
end

Place.seed do |s|
   s.id = 91
   s.title = '顕証寺'
   s.address = '日本, 〒581-0072 大阪府八尾市久宝寺４丁目４−３'
   s.official_url = 'http://www5a.biglobe.ne.jp/~kenshoji/'
end

Place.seed do |s|
   s.id = 92
   s.title = '大信寺'
   s.address = '日本, 〒370-0615 群馬県邑楽郡邑楽町篠塚 群馬県邑楽郡邑楽町大字篠塚3999−2'
   s.official_url = 'http://daishinji.net/'
end

Place.seed do |s|
   s.id = 93
   s.title = '葛井寺'
   s.address = '日本, 〒583-0024 大阪府藤井寺市藤井寺１丁目１６−２１'
   s.official_url = 'http://www.geocities.jp/saikoku33_5/'
end

Place.seed do |s|
   s.id = 94
   s.title = '道明寺'
   s.address = '日本, 〒583-0012 大阪府藤井寺市道明寺'
end

Place.seed do |s|
   s.id = 95
   s.title = '叡福寺'
   s.address = '日本, 〒583-0995 大阪府南河内郡太子町太子 太子町太子２１４６'
   s.official_url = 'http://www.shin-saigoku.jp/temple/11_eifukuji_01.html'
end

Place.seed do |s|
   s.id = 96
   s.title = '弘川寺'
   s.address = '日本, 〒585-0022 大阪府南河内郡河南町弘川４３'
   s.official_url = 'http://www.town.kanan.osaka.jp/kananchotte/kankogaido/terajinja/1394613320825.html'
end

Place.seed do |s|
   s.id = 97
   s.title = '観心寺'
   s.address = '日本, 〒586-0053 大阪府河内長野市寺元475'
   s.official_url = 'http://www.kanshinji.com/'
end

Place.seed do |s|
   s.id = 98
   s.title = '金剛寺'
   s.address = '315 台湾 新竹県 峨眉郷'
   s.official_url = 'http://www.wlig999.com/mobile/edcontent.php?lang=tw&tb=7&cid=35'
end

Place.seed do |s|
   s.id = 99
   s.title = '願泉寺'
   s.address = '日本, 〒597-0003 大阪府貝塚市中８４６'
   s.official_url = 'http://www.eonet.ne.jp/~gansenji'
end

Place.seed do |s|
   s.id = 100
   s.title = '水間寺'
   s.address = '日本, 〒597-0104 大阪府貝塚市水間６３８'
   s.official_url = 'http://www.mizumadera.or.jp/index.html'
end

Place.seed do |s|
   s.id = 101
   s.title = '七宝瀧寺'
   s.address = '日本, 〒598-0023 大阪府泉佐野市大木８'
   s.official_url = 'http://www.inunakisan.jp/'
end

Place.seed do |s|
   s.id = 102
   s.title = '家原寺'
   s.address = '日本, 〒593-8304 大阪府堺市西区家原寺町１丁８−２０'
   s.official_url = 'http://www.chiemonjyuebaraji.jp/'
end

Place.seed do |s|
   s.id = 103
   s.title = '施福寺'
   s.address = '日本, 〒594-1131 大阪府和泉市槇尾山町136'
   s.official_url = 'http://saikoku33.gr.jp/place/4'
end

Place.seed do |s|
   s.id = 104
   s.title = '三井寺'
   s.address = '日本, 〒520-0036 滋賀県大津市園城寺町２４６'
   s.official_url = 'http://www.shiga-miidera.or.jp/'
end

Place.seed do |s|
   s.id = 105
   s.title = '石山寺'
   s.address = '日本, 〒520-0861 滋賀県大津市石山寺'
end

Place.seed do |s|
   s.id = 106
   s.title = '岩間寺'
   s.address = '日本, 〒520-0869 滋賀県大津市石山内畑町82'
   s.official_url = 'http://www.iwama-dera.or.jp/'
end

Place.seed do |s|
   s.id = 107
   s.title = '善水寺'
   s.address = '日本, 〒520-3252 滋賀県湖南市岩根３５１８'
   s.official_url = 'http://www.zensuiji.jp/'
end

Place.seed do |s|
   s.id = 108
   s.title = '常楽寺'
   s.address = '日本, 〒247-0056 神奈川県鎌倉市大船５丁目８−２９'
end

Place.seed do |s|
   s.id = 109
   s.title = '長寿寺'
   s.address = '日本, 〒247-0062 神奈川県鎌倉市山ノ内１５２０'
end

Place.seed do |s|
   s.id = 110
   s.title = '長命寺'
   s.address = '日本, 〒131-0033 東京都墨田区向島５丁目４−４'
end

Place.seed do |s|
   s.id = 111
   s.title = '観音正寺'
   s.address = '日本, 〒521-1331 滋賀県近江八幡市安土町石寺２'
   s.official_url = 'http://www.kannon.or.jp/'
end

Place.seed do |s|
   s.id = 112
   s.title = '桑實寺'
   s.address = '日本, 〒521-1321 滋賀県近江八幡市安土町桑実寺２９２'
end

Place.seed do |s|
   s.id = 113
   s.title = '教林坊'
   s.address = '日本, 〒521-1331 滋賀県近江八幡市安土町石寺 滋賀県近江八幡市安土町石寺1145'
   s.official_url = 'http://www.d1.dion.ne.jp/~marche/kyourinbou/'
end

Place.seed do |s|
   s.id = 114
   s.title = '石塔寺'
   s.address = '日本, 〒529-1501 滋賀県東近江市石塔町８６０'
   s.official_url = 'http://www.biwa.ne.jp/~tam/sansaku/report/26%20ishidoji/ishidoji.html'
end

Place.seed do |s|
   s.id = 115
   s.title = '百済寺'
   s.address = '日本, 〒527-0144 滋賀県東近江市百済寺町３２３'
   s.official_url = 'http://www.hyakusaiji.jp/'
end

Place.seed do |s|
   s.id = 116
   s.title = '西明寺'
   s.address = '日本, 〒522-0254 滋賀県犬上郡甲良町池寺２６'
   s.official_url = 'http://www.saimyouji.com/'
end

Place.seed do |s|
   s.id = 117
   s.title = '金剛輪寺'
   s.address = '日本, 〒529-1202 滋賀県愛知郡愛荘町松尾寺８７４'
   s.official_url = 'http://kongourinji.jp/'
end

Place.seed do |s|
   s.id = 118
   s.title = '宝厳寺'
   s.address = '日本, 〒526-0124 滋賀県長浜市早崎町１６６４−１'
   s.official_url = 'http://www.chikubushima.jp/'
end

Place.seed do |s|
   s.id = 119
   s.title = '興聖寺'
   s.address = '日本, 〒611-0021 京都府宇治市宇治山田２７−１'
   s.official_url = 'http://kyoto-uji-kankou.or.jp/others/corse/shot/index.html'
end

Place.seed do |s|
   s.id = 120
   s.title = '紀三井寺'
   s.address = '日本, 〒641-0012 和歌山県和歌山市紀三井寺１２０１'
   s.official_url = 'http://www.kimiidera.com/'
end

Place.seed do |s|
   s.id = 121
   s.title = '根来寺'
   s.address = '日本, 〒649-6202 和歌山県岩出市根来２２８６'
   s.official_url = 'http://www.negoroji.org/'
end

Place.seed do |s|
   s.id = 122
   s.title = '粉河寺'
   s.address = '日本, 〒649-6531 和歌山県紀の川市粉河 粉河2787'
   s.official_url = 'http://www.kokawadera.org/'
end

Place.seed do |s|
   s.id = 123
   s.title = '慈尊院'
   s.address = '日本, 〒648-0151 和歌山県伊都郡九度山町慈尊院'
end

Place.seed do |s|
   s.id = 124
   s.title = '高野山'
   s.address = 'Koya-san, 高野山 高野町 伊都郡 和歌山県 648-0211 日本'
end

Place.seed do |s|
   s.id = 125
   s.title = '道成寺'
   s.address = '日本, 〒649-1331 和歌山県日高郡日高川町鐘巻１７３８'
   s.official_url = 'http://www.dojoji.com/'
end

Place.seed do |s|
   s.id = 126
   s.title = '青岸渡寺'
   s.address = '日本, 〒649-5301 和歌山県東牟婁郡那智勝浦町大字那智山８'
   s.official_url = 'http://www.nachikan.jp/kumano/seigantoji/'
end

Place.seed do |s|
   s.id = 127
   s.title = '無量寺'
   s.address = '日本, 〒920-0333 石川県金沢市無量寺'
end

Place.seed do |s|
   s.id = 128
   s.title = '橿原神宮'
   s.address = '日本, 〒634-8550 奈良県橿原市久米町９３４'
   s.official_url = 'http://www.kashiharajingu.or.jp/'
end

Place.seed do |s|
   s.id = 129
   s.title = '春日大社'
   s.address = '日本, 〒630-8212 奈良県奈良市春日野町１６０'
   s.official_url = 'http://www.kasugataisha.or.jp/'
end

Place.seed do |s|
   s.id = 130
   s.title = '石上神宮'
   s.address = '日本, 〒632-0014 奈良県天理市布留町３８４'
   s.official_url = 'http://www.isonokami.jp/'
end

Place.seed do |s|
   s.id = 131
   s.title = '檜原神社'
   s.address = '日本, 〒633-0001 奈良県桜井市三輪 奈良県桜井市大字三輪１４２２'
end

Place.seed do |s|
   s.id = 132
   s.title = '大神神社'
   s.address = '日本, 〒633-8538 奈良県桜井市三輪1422'
   s.official_url = 'http://oomiwa.or.jp/'
end

Place.seed do |s|
   s.id = 133
   s.title = '談山神社'
   s.address = '日本, 〒633-0032 奈良県桜井市多武峰319'
   s.official_url = 'http://www.tanzan.or.jp/'
end

Place.seed do |s|
   s.id = 134
   s.title = '一言主神社'
   s.address = '日本, 〒303-0045 茨城県常総市大塚戸町８７５'
   s.official_url = 'http://www.hitokoto.or.jp/'
end

Place.seed do |s|
   s.id = 135
   s.title = '高天彦神社'
   s.address = '日本, 〒639-2336 奈良県御所市北窪 奈良県御所市高天'
   s.official_url = 'http://takama.sakura.ne.jp/takamahikojinjya'
end

Place.seed do |s|
   s.id = 136
   s.title = '葛木神社'
   s.address = '日本, 〒639-2336 奈良県御所市高天 高天４７２'
   s.official_url = 'http://goseshikankou.jp/syousai/otera-zinzya/sonota/katuragi/katuragi.html'
end

Place.seed do |s|
   s.id = 137
   s.title = '丹生川上神社'
   s.address = '日本, 〒632-2431 奈良県吉野郡東吉野村小９６８'
   s.official_url = 'http://www.niukawakami-jinja.jp/'
end

Place.seed do |s|
   s.id = 138
   s.title = '天河大弁財天社'
   s.address = '日本, 〒638-0321 奈良県吉野郡天川村坪内１０７'
   s.official_url = 'http://www.tenkawa-jinja.or.jp/'
end

Place.seed do |s|
   s.id = 139
   s.title = '玉置神社'
   s.address = '日本, 〒647-1582 奈良県吉野郡十津川村玉置川１番地'
   s.official_url = 'http://www.tamakijinja.or.jp/'
end

Place.seed do |s|
   s.id = 140
   s.title = '東大寺'
   s.address = '日本, 〒630-8211 奈良県奈良市雑司町４０６−１'
   s.official_url = 'http://www.todaiji.or.jp/'
end

Place.seed do |s|
   s.id = 141
   s.title = '興福寺'
   s.address = '日本, 〒630-8213 奈良県奈良市登大路町４８'
   s.official_url = 'http://www.kohfukuji.com/'
end

Place.seed do |s|
   s.id = 142
   s.title = '薬師寺'
   s.address = '日本, 〒630-8563 奈良県奈良市西ノ京町４５７'
   s.official_url = 'http://www.nara-yakushiji.com/index.html'
end

Place.seed do |s|
   s.id = 143
   s.title = '唐招提寺'
   s.address = '日本, 〒630-8032 奈良県奈良市五条町１３−４６'
   s.official_url = 'http://www.toshodaiji.jp/'
end

Place.seed do |s|
   s.id = 144
   s.title = '正暦寺'
   s.address = '日本, 〒630-8413 奈良県奈良市菩提山町１５７'
   s.official_url = 'http://shoryakuji.jp/'
end

Place.seed do |s|
   s.id = 145
   s.title = '円成寺'
   s.address = '日本, 〒630-1244 奈良県奈良市忍辱山町1273'
   s.official_url = 'http://www.enjyouji.jp/'
end

Place.seed do |s|
   s.id = 146
   s.title = '新薬師寺'
   s.address = '日本, 〒630-8301 奈良県奈良市高畑町 高畑町１３５２'
   s.official_url = 'http://www.shinyakushiji.or.jp/'
end

Place.seed do |s|
   s.id = 147
   s.title = '西大寺'
   s.address = '日本, 〒631-0825 奈良県奈良市西大寺芝町１丁目１−５'
   s.official_url = 'http://saidaiji.or.jp/'
end

Place.seed do |s|
   s.id = 148
   s.title = '般若寺'
   s.address = '日本, 〒630-8102 奈良県奈良市般若寺町'
end

Place.seed do |s|
   s.id = 149
   s.title = '法華寺'
   s.address = '日本, 〒630-8001 奈良県奈良市法華寺町'
end

Place.seed do |s|
   s.id = 150
   s.title = '霊山寺'
   s.address = '日本, 〒631-0052 奈良県奈良市中町3879'
   s.official_url = 'http://www.ryosenji.jp/'
end

Place.seed do |s|
   s.id = 151
   s.title = '白毫寺'
   s.address = '日本, 〒630-8302 奈良県奈良市白毫寺町'
end

Place.seed do |s|
   s.id = 152
   s.title = '弘仁寺'
   s.address = '日本, 〒630-8412 奈良県奈良市虚空蔵町 奈良県奈良市虚空蔵町４６'
   s.official_url = 'http://www.kouninji.org/'
end

Place.seed do |s|
   s.id = 153
   s.title = '法隆寺'
   s.address = '日本, 〒636-0115 奈良県生駒郡斑鳩町法隆寺山内１−１'
   s.official_url = 'http://www.horyuji.or.jp/'
end

Place.seed do |s|
   s.id = 154
   s.title = '法輪寺'
   s.address = '日本, 〒616-0006 京都府京都市西京区嵐山虚空蔵山町１６'
   s.official_url = 'http://www.kokuzohourinji.com/'
end

Place.seed do |s|
   s.id = 155
   s.title = '法起寺'
   s.address = '日本, 〒636-0102 奈良県生駒郡斑鳩町岡本１８７３番地'
   s.official_url = 'http://www.horyuji.or.jp/hokiji.htm'
end

Place.seed do |s|
   s.id = 156
   s.title = '信貴山朝護孫子寺'
   s.address = '日本, 〒636-0923 奈良県生駒郡平群町信貴山２２８０−１'
   s.official_url = 'http://www.sigisan.or.jp/'
end

Place.seed do |s|
   s.id = 157
   s.title = '宝山寺'
   s.address = '日本, 〒630-0266 奈良県生駒市門前町１−１'
   s.official_url = 'http://www.hozanji.com/'
end

Place.seed do |s|
   s.id = 158
   s.title = '竹林寺'
   s.address = 'No. 325, Zhulin Road, Linkou District, New Taipei City, 台湾 244'
   s.official_url = 'http://www.zlskyt.com.tw/'
end

Place.seed do |s|
   s.id = 159
   s.title = '松尾寺'
   s.address = '日本, 〒639-1057 奈良県大和郡山市山田町６８３'
   s.official_url = 'http://www.matsuodera.com/'
end

Place.seed do |s|
   s.id = 160
   s.title = '矢田寺'
   s.address = '日本, 〒639-1058 奈良県大和郡山市矢田町３５４９'
   s.official_url = 'http://www.yatadera.or.jp/'
end

Place.seed do |s|
   s.id = 161
   s.title = '東明寺'
   s.address = '日本, 〒639-1058 奈良県大和郡山市矢田町２２３０ 639 1058'
   s.official_url = 'http://toumyouji.com/'
end

Place.seed do |s|
   s.id = 162
   s.title = '長岳寺'
   s.address = '日本, 〒632-0052 兵庫県天理市柳本町508'
   s.official_url = 'http://www.chogakuji.or.jp/'
end

Place.seed do |s|
   s.id = 163
   s.title = '百済寺'
   s.address = '日本, 〒527-0144 滋賀県東近江市百済寺町３２３'
   s.official_url = 'http://www.hyakusaiji.jp/'
end

Place.seed do |s|
   s.id = 164
   s.title = '久米寺'
   s.address = '日本, 〒634-0063 奈良県橿原市久米町５０２'
   s.official_url = 'http://www.city.kashihara.nara.jp/kankou/own_kankou/kankou/spot/kumedera.html'
end

Place.seed do |s|
   s.id = 165
   s.title = '称念寺'
   s.address = '日本, 〒602-8498 京都府京都市上京区寺之内通浄福寺西上る西熊町２７５'
   s.official_url = 'http://nekodera.net/'
end

Place.seed do |s|
   s.id = 166
   s.title = '南法華寺'
   s.address = '日本, 〒635-0102 奈良県高市郡高取町壷阪3'
   s.official_url = 'http://www.tsubosaka1300.or.jp/'
end

Place.seed do |s|
   s.id = 167
   s.title = '岡寺'
   s.address = '日本, 〒634-0111 奈良県高市郡明日香村岡８０６'
   s.official_url = 'http://www.okadera3307.com/'
end

Place.seed do |s|
   s.id = 168
   s.title = '長谷寺'
   s.address = '日本, 〒248-0016 神奈川県鎌倉市長谷３丁目１１−２'
   s.official_url = 'http://www.hasedera.jp/'
end

Place.seed do |s|
   s.id = 169
   s.title = '室生寺'
   s.address = '日本, 〒633-0421 奈良県宇陀市室生７８'
   s.official_url = 'http://www.murouji.or.jp/'
end

Place.seed do |s|
   s.id = 170
   s.title = '大野寺'
   s.address = '日本, 〒633-0315 奈良県宇陀市室生大野１６８０'
   s.official_url = 'http://www.city.uda.nara.jp/sin-kankou/guide/flower/f04.html'
end

Place.seed do |s|
   s.id = 171
   s.title = '大澤寺'
   s.address = '日本, 〒421-0523 静岡県牧之原市波津８０８−５'
   s.official_url = 'http://www.daitakuji.jp/'
end

Place.seed do |s|
   s.id = 172
   s.title = '転法輪寺'
   s.address = '日本, 〒639-2336 奈良県御所市高天'
end

Place.seed do |s|
   s.id = 173
   s.title = '沙沙貴神社'
   s.address = '日本, 〒521-1351 滋賀県近江八幡市安土町常楽寺２'
   s.official_url = 'http://sasakijinja.or.jp/'
end

Place.seed do |s|
   s.id = 174
   s.title = '日吉大社'
   s.address = '日本, 〒520-0113 滋賀県大津市坂本５丁目１−１'
   s.official_url = 'http://hiyoshitaisha.jp/'
end

Place.seed do |s|
   s.id = 175
   s.title = '都久夫須麻神社'
   s.address = '日本, 〒526-0124 滋賀県長浜市早崎町1665'
   s.official_url = 'http://www.biwako-visitors.jp/spot/detail/1312'
end

Place.seed do |s|
   s.id = 176
   s.title = '湯谷神社'
   s.address = '日本, 〒521-0012 滋賀県米原市米原７７１'
end

Place.seed do |s|
   s.id = 177
   s.title = '多賀大社'
   s.address = '日本, 〒522-0341 滋賀県犬上郡多賀町多賀６０４'
   s.official_url = 'http://www.tagataisya.or.jp/'
end

Place.seed do |s|
   s.id = 178
   s.title = '兵主神社'
   s.address = '日本, 〒520-2424 滋賀県野洲市五条 滋賀県野洲市五条５６６'
end

Place.seed do |s|
   s.id = 179
   s.title = '近江神宮'
   s.address = '日本, 〒520-0015 滋賀県大津市神宮町１−１−１'
   s.official_url = 'http://oumijingu.org/'
end

Place.seed do |s|
   s.id = 180
   s.title = '生田神社'
   s.address = '日本, 〒650-0011 兵庫県神戸市中央区下山手通１丁目２−１'
   s.official_url = 'https://ikutajinja.or.jp/'
end

Place.seed do |s|
   s.id = 181
   s.title = '湊川神社'
   s.address = '日本, 〒650-0015 兵庫県神戸市中央区多聞通３丁目3−1−1'
   s.official_url = 'http://www.minatogawajinja.or.jp/'
end

Place.seed do |s|
   s.id = 182
   s.title = '長田神社'
   s.address = '日本, 〒653-0812 兵庫県神戸市長田区長田区長田町３丁目１−１'
   s.official_url = 'http://nagatajinja.jp/html/'
end

Place.seed do |s|
   s.id = 183
   s.title = '蛭子神社'
   s.address = '日本, 〒652-0806 兵庫県神戸市兵庫区西柳原町５−２０'
   s.official_url = 'http://www.hyogo-ebisu.com/'
end

Place.seed do |s|
   s.id = 184
   s.title = '廣田神社'
   s.address = '日本, 〒662-0867 兵庫県西宮市大社町７ 兵庫県西宮市大社町７−７'
   s.official_url = 'http://www.hirotahonsya.or.jp/'
end

Place.seed do |s|
   s.id = 185
   s.title = '西宮神社'
   s.address = '日本, 〒662-0974 兵庫県西宮市社家町１−１７'
   s.official_url = 'http://nishinomiya-ebisu.com/'
end

Place.seed do |s|
   s.id = 186
   s.title = '売布神社'
   s.address = '日本, 〒690-0005 島根県松江市和多見町81'
   s.official_url = 'http://www.shinbutsu.jp/37.html'
end

Place.seed do |s|
   s.id = 187
   s.title = '佐保神社'
   s.address = '日本, 〒673-1431 兵庫県加東市社７７７'
   s.official_url = 'http://www.hyogo-jinjacho.com/data/6311091.html'
end

Place.seed do |s|
   s.id = 188
   s.title = '廣峯神社'
   s.address = '日本, 〒670-0891 兵庫県姫路市広嶺山５２'
   s.official_url = 'http://www.hiromine-j.jp/'
end

Place.seed do |s|
   s.id = 189
   s.title = 'おのころ島神社'
   s.address = '日本, 〒656-0423 兵庫県南あわじ市榎列下幡多 兵庫県南あわじ市榎列下幡多415'
   s.official_url = 'http://www.freedom.ne.jp/onokoro/'
end

Place.seed do |s|
   s.id = 190
   s.title = '高砂神社'
   s.address = '日本, 〒676-0043 兵庫県高砂市高砂町東宮町１９０'
   s.official_url = 'http://takasagojinja.takara-bune.net/'
end

Place.seed do |s|
   s.id = 191
   s.title = '鹿嶋神社'
   s.address = '日本, 〒676-0828 兵庫県高砂市阿弥陀町地徳２７９番地'
   s.official_url = 'http://www.kashimajinja.or.jp/'
end

Place.seed do |s|
   s.id = 192
   s.title = '高御位神社'
   s.address = '日本, 〒676-0827 兵庫県高砂市阿弥陀町阿弥陀'
end

Place.seed do |s|
   s.id = 193
   s.title = '生石神社'
   s.address = '日本, 〒676-0823 兵庫県高砂市阿弥陀町生石１７１'
   s.official_url = 'http://www.isinohouden.com/'
end

Place.seed do |s|
   s.id = 194
   s.title = '尾上神社'
   s.address = '日本, 〒675-0024 兵庫県加古川市尾上町長田５１８'
   s.official_url = 'http://kako-navi.jp/spot/spot/purpose/history/927'
end

Place.seed do |s|
   s.id = 195
   s.title = '日前宮'
   s.address = '日本, 〒640-8322 和歌山県和歌山市秋月３６５'
   s.official_url = 'http://hinokuma-jingu.com/'
end

Place.seed do |s|
   s.id = 196
   s.title = '淡嶋神社'
   s.address = '日本, 〒640-0103 和歌山県和歌山市加太 和歌山県和歌山市加太'
   s.official_url = 'http://www.kada.jp/awashima/'
end

Place.seed do |s|
   s.id = 197
   s.title = '伊太祁曽神社'
   s.address = '日本, 〒640-0361 和歌山県和歌山市伊太祈曽558'
   s.official_url = 'http://itakiso-jinja.net/'
end

Place.seed do |s|
   s.id = 198
   s.title = '竈山神社'
   s.address = '日本, 〒641-0004 和歌山県和歌山市和田４３８'
   s.official_url = 'http://www.wakayama-jinjacho.or.jp/jdb/sys/user/GetWjtTbl.php?JinjyaNo=1052'
end

Place.seed do |s|
   s.id = 199
   s.title = '濱宮'
   s.address = '日本, 〒641-0014 和歌山県和歌山市毛見１３０３'
   s.official_url = 'http://wakayama-jinjacho.or.jp/jdb/sys/user/GetWjtTbl.php?JinjyaNo=1046'
end

Place.seed do |s|
   s.id = 200
   s.title = '和歌浦天満宮'
   s.address = '日本, 〒641-0024 和歌山県和歌山市和歌浦西２丁目１−２４'
   s.official_url = 'http://wakamatsuri.com/spot/%E5%92%8C%E6%AD%8C%E6%B5%A6%E5%A4%A9%E6%BA%80%E5%AE%AE'
end

Place.seed do |s|
   s.id = 201
   s.title = '藤白神社'
   s.address = '日本, 〒642-0034 和歌山県海南市藤白４６６'
   s.official_url = 'http://fujishiro-jinja.net/'
end

Place.seed do |s|
   s.id = 202
   s.title = '丹生都比売神社'
   s.address = '日本, 〒649-7141 和歌山県伊都郡かつらぎ町上天野230'
   s.official_url = 'http://www.niutsuhime.or.jp/'
end

Place.seed do |s|
   s.id = 203
   s.title = '隅田八幡神社'
   s.address = '日本, 〒648-0018 和歌山県橋本市隅田町垂井６２２'
   s.official_url = 'http://wakayama-jinjacho.or.jp/jdb/sys/user/GetWjtTbl.php?JinjyaNo=4001'
end

Place.seed do |s|
   s.id = 204
   s.title = '闘鶏神社'
   s.address = '日本, 〒646-0029 和歌山県田辺市東陽１−１'
   s.official_url = 'http://wakayama-jinjacho.or.jp/jdb/sys/user/GetWjtTbl.php?JinjyaNo=7001'
end

Place.seed do |s|
   s.id = 205
   s.title = '神倉神社'
   s.address = '日本, 〒647-0044 和歌山県新宮市神倉１丁目１３−８'
   s.official_url = 'http://kumanohayatama.jp/?page_id=18'
end

Place.seed do |s|
   s.id = 206
   s.title = '伏見稲荷大社'
   s.address = '日本, 〒612-0882 京都府京都市伏見区深草藪之内町６８'
   s.official_url = 'http://inari.jp/'
end

Place.seed do |s|
   s.id = 207
   s.title = '晴明神社'
   s.address = '日本, 〒602-8222 京都府京都市上京区晴明町 堀川通一条上ル晴明町806'
   s.official_url = 'http://www.seimeijinja.jp/'
end

Place.seed do |s|
   s.id = 208
   s.title = '北野天満宮'
   s.address = '日本, 〒602-8386 京都府京都市上京区馬喰町'
   s.official_url = 'http://kitanotenmangu.or.jp/'
end

Place.seed do |s|
   s.id = 209
   s.title = '錦天満宮'
   s.address = '日本, 〒604-8042 京都府京都市中京区中之町（新京極通） 新京極通り四条上る中之町537番地'
   s.official_url = 'http://nishikitenmangu.or.jp/'
end

Place.seed do |s|
   s.id = 210
   s.title = '電電宮'
   s.address = '日本, 〒616-0004 京都府京都市西京区嵐山中尾下町４２−２５'
   s.official_url = 'http://www.kokuzohourinji.com/dendengu.html'
end

Place.seed do |s|
   s.id = 211
   s.title = '車折神社'
   s.address = '日本, 〒616-8343 京都府京都市右京区嵯峨朝日町 右京区嵯峨朝日町２３'
   s.official_url = 'http://www.kurumazakijinja.or.jp/'
end

Place.seed do |s|
   s.id = 212
   s.title = '平安神宮'
   s.address = '日本, 〒606-8341 京都府京都市左京区岡崎西天王町'
   s.official_url = 'http://www.heianjingu.or.jp/'
end

Place.seed do |s|
   s.id = 213
   s.title = '八坂神社'
   s.address = '日本, 〒605-0073 京都府京都市東山区祇園町北側６２５'
   s.official_url = 'http://www.yasaka-jinja.or.jp/'
end

Place.seed do |s|
   s.id = 214
   s.title = '地主神社'
   s.address = '日本, 〒605-0862 京都府京都市東山区清水1丁目317'
   s.official_url = 'http://www.jishujinja.or.jp/'
end

Place.seed do |s|
   s.id = 215
   s.title = '下鴨神社'
   s.address = '日本, 〒606-0807 京都府京都市左京区下鴨泉川町59'
   s.official_url = 'http://www.shimogamo-jinja.or.jp/'
end

Place.seed do |s|
   s.id = 216
   s.title = '上賀茂神社'
   s.address = '日本, 〒603-8047 京都府京都市北区上賀茂本山３３９'
   s.official_url = 'http://www.kamigamojinja.jp/'
end

Place.seed do |s|
   s.id = 217
   s.title = '護王神社'
   s.address = '日本, 〒602-8011 京都府京都市上京区桜鶴円町 烏丸通下長者町下ル桜鶴円町385'
   s.official_url = 'http://www.gooujinja.or.jp/'
end

Place.seed do |s|
   s.id = 218
   s.title = '豊国神社'
   s.address = '日本, 〒605-0931 京都府京都市東山区茶屋町 京都府京都市東山区大和大路通り正面茶屋町530'
   s.official_url = 'http://kanko.city.kyoto.lg.jp/detail.php?InforKindCode=1&ManageCode=1000182'
end

Place.seed do |s|
   s.id = 219
   s.title = '平野神社'
   s.address = '日本, 〒603-8322 京都府京都市北区平野宮本町１'
   s.official_url = 'http://www.hiranojinja.com/'
end

Place.seed do |s|
   s.id = 220
   s.title = '出世稲荷神社'
   s.address = '日本, 〒601-1242 京都府京都市左京区大原来迎院町 京都府京都市左京区大原来迎院町１４８'
   s.official_url = 'http://syusseinari.or.jp/'
end

Place.seed do |s|
   s.id = 221
   s.title = '松尾大社'
   s.address = '日本, 〒616-0024 京都府京都市西京区嵐山宮町３'
   s.official_url = 'http://www.matsunoo.or.jp/'
end

Place.seed do |s|
   s.id = 222
   s.title = '白峯神宮'
   s.address = '日本, 〒602-0054 京都府京都市上京区飛鳥井町 今出川堀川東入飛鳥井261'
   s.official_url = 'http://shiraminejingu.or.jp/'
end

Place.seed do |s|
   s.id = 223
   s.title = '藤森神社'
   s.address = '日本, 〒612-0863 京都府京都市伏見区深草鳥居崎町６０９'
   s.official_url = 'http://www.fujinomorijinjya.or.jp/'
end

Place.seed do |s|
   s.id = 224
   s.title = '長岡天満宮'
   s.address = '日本, 〒617-0824 京都府長岡京市天神２丁目１５−１５−１３'
   s.official_url = 'http://www.nagaokatenmangu.or.jp/'
end

Place.seed do |s|
   s.id = 225
   s.title = '向日神社'
   s.address = '日本, 〒617-0005 京都府向日市向日町北山北山６５'
   s.official_url = 'http://www.geocities.jp/mukojinjahp/'
end

Place.seed do |s|
   s.id = 226
   s.title = '宇治上神社'
   s.address = '日本, 〒611-0021 京都府宇治市宇治山田５９'
   s.official_url = 'http://www.pref.kyoto.jp/isan/ujigami.html'
end

Place.seed do |s|
   s.id = 227
   s.title = '石清水八幡宮'
   s.address = '日本, 〒614-8005 京都府八幡市八幡高坊30'
   s.official_url = 'http://www.iwashimizu.or.jp/'
end

Place.seed do |s|
   s.id = 228
   s.title = '土佐稲荷神社'
   s.address = '日本, 〒550-0014 大阪府大阪市西区北堀江４丁目９−７'
   s.official_url = 'http://www.tosainari.jp/'
end

Place.seed do |s|
   s.id = 229
   s.title = 'サムハラ神社'
   s.address = '日本, 〒550-0012 大阪府大阪市西区立売堀２丁目５−２６'
end

Place.seed do |s|
   s.id = 230
   s.title = '大阪天満宮'
   s.address = '日本, 〒530-0041 大阪府大阪市北区天神橋２丁目１−1番8'
   s.official_url = 'http://www.tenjinsan.com/'
end

Place.seed do |s|
   s.id = 231
   s.title = '少彦名神社'
   s.address = '日本, 〒541-0045 大阪府大阪市中央区道修町２丁目１−８'
   s.official_url = 'http://www.sinnosan.jp/onrei.html'
end

Place.seed do |s|
   s.id = 232
   s.title = '難波神社'
   s.address = '日本, 〒541-0059 大阪府大阪市中央区博労町４丁目２−1番3'
   s.official_url = 'http://www.nanba-jinja.or.jp/'
end

Place.seed do |s|
   s.id = 233
   s.title = '坐摩神社'
   s.address = '日本, 〒541-0056 大阪府大阪市中央区久太郎町４丁目渡辺３号'
   s.official_url = 'http://www.ikasuri.or.jp/'
end

Place.seed do |s|
   s.id = 234
   s.title = '御霊神社'
   s.address = '日本, 〒248-0021 神奈川県鎌倉市坂ノ下４ 248-0021 神奈川県鎌倉市坂ノ下4-9'
   s.official_url = 'https://www.city.kamakura.kanagawa.jp/kamakura-kankou/meisho/02goryoujinja.html'
end

Place.seed do |s|
   s.id = 235
   s.title = '玉造稲荷神社'
   s.address = '日本, 〒540-0004 大阪府大阪市中央区中央区玉造２丁目３−８'
   s.official_url = 'http://www.inari.or.jp/'
end

Place.seed do |s|
   s.id = 236
   s.title = '高津宮'
   s.address = '日本, 〒542-0072 大阪府大阪市中央区高津１丁目１−２９'
   s.official_url = 'http://www.kouzu.or.jp/'
end

Place.seed do |s|
   s.id = 237
   s.title = '大江神社'
   s.address = '日本, 〒543-0075 大阪府大阪市天王寺区夕陽丘町５−４０'
   s.official_url = 'http://ooejinja.net/index.html'
end

Place.seed do |s|
   s.id = 238
   s.title = '生國魂神社'
   s.address = '日本, 〒543-0071 大阪府大阪市天王寺区生玉町１３−９'
   s.official_url = 'http://www.jinjacho-osaka.net/osakafunai-no-jinjya/dai8sibu/tennouji-ku/m01i_01_tennouji_ikukunitama.html'
end

Place.seed do |s|
   s.id = 239
   s.title = '三光神社'
   s.address = '日本, 〒543-0013 大阪府大阪市天王寺区玉造本町１４−９０'
   s.official_url = 'http://sankoujinja.com/index.html'
end

Place.seed do |s|
   s.id = 240
   s.title = '日吉神社'
   s.address = '日本, 〒010-1622 秋田県秋田市新屋日吉町１０−６７'
   s.official_url = 'http://hiyoshi-jinja.jp/'
end

Place.seed do |s|
   s.id = 241
   s.title = '神須牟地神社'
   s.address = '日本, 〒558-0002 大阪府大阪市住吉区長居西２丁目１−４'
   s.official_url = 'http://www.jinjacho-osaka.net/osakafunai-no-jinjya/dai9sibu/sumiyosi-ku/m01u_04_sumiyosi_kamisumuti.html'
end

Place.seed do |s|
   s.id = 242
   s.title = '堀越神社'
   s.address = '日本, 〒543-0063 大阪府大阪市天王寺区茶臼山町１−８'
   s.official_url = 'http://horikoshijinja.or.jp/'
end

Place.seed do |s|
   s.id = 243
   s.title = '今宮戎神社'
   s.address = '日本, 〒556-0003 大阪府大阪市浪速区恵美須西１丁目６−６番10号'
   s.official_url = 'http://www.imamiya-ebisu.jp/'
end

Place.seed do |s|
   s.id = 244
   s.title = '難波八阪神社'
   s.address = '日本, 〒556-0016 大阪府大阪市浪速区元町２丁目９−１９'
   s.official_url = 'http://nambayasaka.jp/'
end

Place.seed do |s|
   s.id = 245
   s.title = '石切神社'
   s.address = '日本, 〒579-8013 大阪府東大阪市東石切町１丁目１−１'
   s.official_url = 'http://www.ishikiri.or.jp/'
end

Place.seed do |s|
   s.id = 246
   s.title = '枚岡神社'
   s.address = '日本, 〒579-8033 大阪府東大阪市出雲井町７−１６'
   s.official_url = 'http://www.hiraoka-jinja.org/'
end

Place.seed do |s|
   s.id = 247
   s.title = '瓢箪山稲荷神社'
   s.address = '日本, 〒579-8051 大阪府東大阪市瓢箪山町８−１'
   s.official_url = 'http://kamnavi.jp/inari/hyoutan.htm'
end

Place.seed do |s|
   s.id = 248
   s.title = '布施戎神社'
   s.address = '日本, 〒577-0841 大阪府東大阪市足代１丁目１５−２１'
   s.official_url = 'https://www.facebook.com/fuse.ebisu/'
end

Place.seed do |s|
   s.id = 249
   s.title = '開口神社'
   s.address = '日本, 〒590-0953 大阪府堺市堺区甲斐町東２丁１−２９'
   s.official_url = 'http://www.aguchi.jp/'
end

Place.seed do |s|
   s.id = 250
   s.title = '道明寺天満宮'
   s.address = '日本, 〒583-0012 大阪府藤井寺市道明寺１丁目１６ 道明寺1丁目16−40'
   s.official_url = 'http://www.domyojitenmangu.com/'
end

Place.seed do |s|
   s.id = 251
   s.title = '建水分神社'
   s.address = '日本, 〒585-0041 大阪府南河内郡水分 千早赤阪村水分３５７'
   s.official_url = 'http://www.takemikumari.com/'
end

Place.seed do |s|
   s.id = 252
   s.title = '伊居太神社'
   s.address = '日本, 〒563-0051 大阪府池田市綾羽２丁目４−５'
   s.official_url = 'http://www.ikeda-jinjya.jp/'
end

Place.seed do |s|
   s.id = 253
   s.title = '萱島神社'
   s.address = '日本, 〒572-0827 大阪府寝屋川市萱島本町19−1 京阪萱島駅高架下'
end
