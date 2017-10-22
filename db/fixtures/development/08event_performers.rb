# frozen_string_literal: true

id = 12
ev_program_id = 12
idxs = [id, ev_program_id]

def insert_ev_performer_to_event(idxs, ev_performers)
   id = idxs[0]
   ev_program_id = idxs[1]

   ev_performers.each do |ev_performer|
      performer_id = ev_performer
      EventPerformer.seed do |s|
         s.id = id
         s.event_program_id = ev_program_id
         s.performer_id = performer_id
      end
      id += 10
   end
   ev_program_id += 10

   idxs[0] = id
   idxs[1] = ev_program_id
end

# 2017/9/8 夕暮れ能
# 仕舞(ｸｾ) 「紅葉狩」
ev_performers = [8122]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「鵺」
ev_performers = [8132]
insert_ev_performer_to_event(idxs, ev_performers)

# 能(盤渉) 「羽衣」
ev_performers = [8182, 8322, 8412, 8432, 8552,
                 8602, 8222, 8282, 8232, 8102,
                 8122, 8192, 8132, 8192]
insert_ev_performer_to_event(idxs, ev_performers)

# 半能(白頭) 「小鍛冶」
ev_performers = [8182, 8322, 8412, 8432, 8552,
                 8602, 8232, 8132, 8102, 8222,
                 8122, 8192, 8282, 11722]
insert_ev_performer_to_event(idxs, ev_performers)


# 2017/9/24 第七回 金剛定期能
# 仕舞(ｷﾘ) 生田敦盛
ev_performers = [8122]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(ｸﾙｲ) 花筐
ev_performers = [9722]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「黒塚」
ev_performers = [8102]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「七騎落」
ev_performers = [8322, 8222, 8192, 8132, 8282,
                 11722, 8262, 11732, 4072, 10242,
                 8392, 8452, 8552, 9722, 8112]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「鏡男」
ev_performers = [10212, 10182]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「天鼓」
ev_performers = [8182, 8362, 10202, 8412, 8432,
                 10102, 8602, 3622, 8272]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/11/18 東京金剛界 第四回例会能
# 研修能 「小鍛冶」
ev_performers = [3542]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「経正」
ev_performers = [3652]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「葛城」
ev_performers = [3602]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/8 種田後演会能
# 能(女体) 「殺生石」
ev_program_122 = [8212]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/8/16 第15回 大文字送り火能 ～蝋燭能～
# 能(替装束) 「通小町」
ev_performers = [3622, 8182, 10532, 8382, 8432,
                 8552, 8142, 8232, 8112, 8212,
                 8262, 8102, 8222, 8122, 8132,
                 8282]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/1 金沢能楽会定期能
# 能 「半蔀」
ev_performers = [7062, 7082, 7232, 7212, 7102,
                 7302, 6932, 6992, 6872, 3112,
                 7032, 7012, 6812, 7052, 6842,
                 6702]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「謀生種」
ev_performers = [7392, 7362, 7352]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「経正(サイトでは「経政」と表記)」
ev_performers = [6742, 3502, 6932, 3112, 11742]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「阿漕」
ev_performers = [3182, 7092, 7072, 7222, 7252,
                 7192, 7112, 7382, 6982, 6942,
                 7042, 3112, 7002, 6802, 6952,
                 6752, 6652, 3502]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/12 観世会荒磯能
# 仕舞(ｷﾘ) 「敦盛」
ev_performers = [832]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(ｸｾ) 「花月」
ev_performers = [11752]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(楽ｱﾄ) 「邯鄲」
ev_performers = [992, 162, 252, 532, 11762]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「楊貴妃」
ev_performers = [992, 4162, 5272, 4442, 4612,
                 4792, 1232, 1572, 1172, 1102,
                 842, 1692, 802, 1222, 222,
                 682]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「柿山伏」
ev_performers = [5282, 5312]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「善界」
ev_performers = [1162, 1242, 4142, 5252, 8392,
                 4602, 4762, 4932, 732, 1702,
                 1092, 1022, 1002, 1262, 1042,
                 1192, 822, 11772]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/09/02 浦田定期能
# 能 「頼政」
ev_performers = [7472, 9872, 8662, 8402, 8432,
                 10102, 7832, 7582, 7842, 7892,
                 7802, 7942, 7622, 7952, 11782,
                 11792]
insert_ev_performer_to_event(idxs, ev_performers)

# 素謡 「野宮」
ev_performers = [7672, 7482, 11802, 7942, 7622,
                 7742]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「惣八」
ev_performers = [8682, 8652, 8612, 8782]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「老松」
ev_performers = [7702, 7832, 7892, 7802, 7612]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「巴」
ev_performers = [11792, 7832, 7892, 7802, 7612]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「松風」
ev_performers = [7482, 7832, 7892, 7802, 7612]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「善知鳥」
ev_performers = [7582, 7832, 7892, 7802, 7612]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「杜若」
ev_performers = [11812, 8342, 8372, 8492, 8562,
                 8592]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/09/24 京都観世会九月例会
# 能 「盛久」
ev_performers = [7862, 9832, 4072, 9852, 10552,
                 10102, 8432, 8412, 7632, 7402,
                 7622, 7542, 7462, 7752, 7582,
                 7602, 7572, 7472]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「仏師」
ev_performers = [8722, 8812]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「夕顔」
ev_performers = [7532, 8342, 8352, 8322, 8542,
                 10012, 9892, 7522, 32, 11782,
                 7842, 7972, 7922, 7412, 7672,
                 7482, 7642]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(ｷﾘ) 「敦盛」
ev_performers = [7802, 7622, 7652, 7772, 7582]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞「楊貴妃」
ev_performers = [7822, 7622, 7652, 7772, 7582]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞「殺生石」
ev_performers = [7942, 7622, 7652, 7772, 7582]
insert_ev_performer_to_event(idxs, ev_performers)

# 能「鉄輪」
ev_performers = [7992, 8342, 8322, 8512, 8502,
                 8592, 8372, 7702, 7452, 7512,
                 7592, 7612, 7892, 7792, 7912,
                 8002, 7492]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/15 第３４回　横浜かもんやま能
# 狂言 萩大名」
ev_performers = [8702, 8672, 8792, 8742]
insert_ev_performer_to_event(idxs, ev_performers)

# 能(盲目之舞)「弱法師」
ev_performers = [742, 4242, 8672, 4272, 4572,
                 4752, 1082, 252, 1542, 1072,
                 262, 672, 1572, 422, 152,
                 722]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/28 能の花　能を彩る花　第１回「菊」
# 能(酈縣山)「菊慈童」
ev_performers = [372, 4242, 4232, 4142, 4112,
                 4212, 5332, 4272, 4612, 4852,
                 5002, 392, 1852, 602, 362,
                 1792, 632, 1802, 702, 1442,
                 7662, 11822]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/11/23 能の花　能を彩る花　第２回「紅葉」
# 能(紅葉ノ舞 群鬼ノ伝)「紅葉狩」
ev_performers = [2222, 2212, 2012, 2432, 2612,
                 4142, 4122, 4192, 4262, 8672,
                 8692, 4292, 4642, 4802, 5012,
                 2602, 2382, 2672, 5912, 2492,
                 2712, 2232, 2152]
insert_ev_performer_to_event(idxs, ev_performers)

# 2018/1/23 能の花　能を彩る花　第3回「牡丹」
# 能(大獅子)「石橋」
ev_performers = [7572, 11832, 4242, 5562, 8392,
                 10002, 4742, 4912, 7402, 8002,
                 7462, 1852, 772, 7862, 7912,
                 632, 1632, 702, 1442]
insert_ev_performer_to_event(idxs, ev_performers)

# 2018/2/10 能の花　能を彩る花　第4回「梅」
# 能「東北」
ev_performers = [9022, 4072, 11842, 11852, 5282,
                 4472, 11302, 4772, 9202, 11862,
                 192, 162, 1102, 252, 802,
                 932, 222, 682]
insert_ev_performer_to_event(idxs, ev_performers)

# 2018/3/10 能の花　能を彩る花　第５回「桜」
# 能「泰山府君」
ev_performers = [3622, 8182, 4242, 5412, 6352,
                 4542, 4812, 4972, 8262, 8232,
                 3612, 8272, 8142, 8222, 3772,
                 8122, 3652, 3762, 3602]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/9/18 山本能楽堂90周年記念 とくい能　特別公演 卒都婆小町
# 能(一度之次第) 「卒都婆小町」
ev_performers = [9292, 4072, 9822, 9892, 10002,
                 10092, 9342, 9302, 9412, 7702,
                 9422, 10522, 10732, 8952, 7622,
                 11872]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/1 一聲能
# 半能 「小鍛冶」
ev_performers = [10732, 8352, 8372, 11882, 10122,
                 10172, 9342, 9302, 9412, 10522,
                 8932, 11872]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/4 10月定例公演　仁王・龍田
# 狂言 「仁王」
ev_performers = [5582, 5592, 5632, 5382, 5572,
                 5372, 11892, 5602]
insert_ev_performer_to_event(idxs, ev_performers)

# 能(移神楽) 「龍田」
ev_performers = [182, 4222, 4122, 4202, 5402,
                 8392, 8472, 4792, 4912, 8892,
                 172, 152, 1622, 952, 262,
                 462, 452, 1612, 352]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/14 10月普及公演　泣尼・枕慈童
# 狂言 「泣尼」
ev_performers = [5512, 5482, 6572]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「枕慈童」
ev_performers = [4042, 4142, 4212, 4262, 4352,
                 11282, 4812, 7272, 4002, 3912,
                 3852, 3842, 3882, 4012, 4022,
                 4052, 3862, 3902]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/20 10月定例公演　御茶の水・養老
# 狂言 「御茶の水」
ev_performers = [8792, 8612, 8712]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 (水波之伝) 「養老」
ev_performers = [1232, 1242, 11762, 9862, 11852,
                  4102, 6352, 4572, 4872, 4922,
                  1252, 1342, 1092, 1002, 992,
                  1012, 1222, 1762, 502, 1272,
                  1872]
insert_ev_performer_to_event(idxs, ev_performers)
