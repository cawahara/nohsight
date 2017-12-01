# frozen_string_literal: true

id = 1
ev_program_id = 1
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
      id += 1
   end
   ev_program_id += 1

   idxs[0] = id
   idxs[1] = ev_program_id
end

# 2017/9/8 夕暮れ能
# 仕舞(ｸｾ) 「紅葉狩」
ev_performers = [812]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「鵺」
ev_performers = [813]
insert_ev_performer_to_event(idxs, ev_performers)

# 能(盤渉) 「羽衣」
ev_performers = [818, 832, 841, 843, 855,
                 860, 822, 828, 823, 810,
                 812, 819, 813, 819]
insert_ev_performer_to_event(idxs, ev_performers)

# 半能(白頭) 「小鍛冶」
ev_performers = [818, 832, 841, 843, 855,
                 860, 823, 813, 810, 822,
                 812, 819, 828, 1172]
insert_ev_performer_to_event(idxs, ev_performers)


# 2017/9/24 第七回 金剛定期能
# 仕舞(ｷﾘ) 生田敦盛
ev_performers = [812]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(ｸﾙｲ) 花筐
ev_performers = [972]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「黒塚」
ev_performers = [810]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「七騎落」
ev_performers = [832, 822, 819, 813, 828,
                 1172, 826, 1173, 407, 1024,
                 839, 845, 855, 972, 811]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「鏡男」
ev_performers = [1021, 1018]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「天鼓」
ev_performers = [818, 836, 1020, 841, 843,
                 1010, 860, 362, 827]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/11/18 東京金剛界 第四回例会能
# 研修能 「小鍛冶」
ev_performers = [354]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「経正」
ev_performers = [365]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「葛城」
ev_performers = [360]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/8 種田後演会能
# 能(女体) 「殺生石」
ev_program_122 = [821]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/8/16 第15回 大文字送り火能 ～蝋燭能～
# 能(替装束) 「通小町」
ev_performers = [362, 818, 1053, 838, 843,
                 855, 814, 823, 811, 821,
                 826, 810, 822, 812, 813,
                 828]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/1 金沢能楽会定期能
# 能 「半蔀」
ev_performers = [706, 708, 723, 721, 710,
                 730, 693, 699, 687, 311,
                 703, 701, 681, 705, 684,
                 670]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「謀生種」
ev_performers = [739, 736, 735]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「経正(サイトでは「経政」と表記)」
ev_performers = [674, 350, 693, 311, 1174]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「阿漕」
ev_performers = [318, 709, 707, 722, 725,
                 719, 711, 738, 698, 694,
                 704, 311, 700, 680, 695,
                 675, 665, 350]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/12 観世会荒磯能
# 仕舞(ｷﾘ) 「敦盛」
ev_performers = [83]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(ｸｾ) 「花月」
ev_performers = [1175]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(楽ｱﾄ) 「邯鄲」
ev_performers = [99, 16, 25, 53, 1176]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「楊貴妃」
ev_performers = [99, 416, 527, 444, 461,
                 479, 123, 157, 117, 110,
                 84, 169, 80, 122, 22,
                 68]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「柿山伏」
ev_performers = [528, 531]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「善界」
ev_performers = [116, 124, 414, 525, 839,
                 460, 476, 493, 73, 170,
                 109, 102, 100, 126, 104,
                 119, 82, 1177]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/09/02 浦田定期能
# 能 「頼政」
ev_performers = [747, 987, 866, 840, 843,
                 1010, 783, 758, 784, 789,
                 780, 794, 762, 795, 1178,
                 1179]
insert_ev_performer_to_event(idxs, ev_performers)

# 素謡 「野宮」
ev_performers = [767, 748, 1180, 794, 762,
                 774]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「惣八」
ev_performers = [868, 865, 861, 878]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「老松」
ev_performers = [770, 783, 789, 780, 761]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「巴」
ev_performers = [1179, 783, 789, 780, 761]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「松風」
ev_performers = [748, 783, 789, 780, 761]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞 「善知鳥」
ev_performers = [758, 783, 789, 780, 761]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「杜若」
ev_performers = [1181, 834, 837, 849, 856,
                 859]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/09/24 京都観世会九月例会
# 能 「盛久」
ev_performers = [786, 983, 407, 985, 1055,
                 1010, 843, 841, 763, 740,
                 762, 754, 746, 775, 758,
                 760, 757, 747]
insert_ev_performer_to_event(idxs, ev_performers)

# 狂言 「仏師」
ev_performers = [872, 881]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「夕顔」
ev_performers = [753, 834, 835, 832, 854,
                 1001, 989, 752, 3, 1178,
                 784, 797, 792, 741, 767,
                 748, 764]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞(ｷﾘ) 「敦盛」
ev_performers = [780, 762, 765, 777, 758]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞「楊貴妃」
ev_performers = [782, 762, 765, 777, 758]
insert_ev_performer_to_event(idxs, ev_performers)

# 仕舞「殺生石」
ev_performers = [794, 762, 765, 777, 758]
insert_ev_performer_to_event(idxs, ev_performers)

# 能「鉄輪」
ev_performers = [799, 834, 832, 851, 850,
                 859, 837, 770, 745, 751,
                 759, 761, 789, 779, 791,
                 800, 749]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/15 第３４回　横浜かもんやま能
# 狂言 萩大名」
ev_performers = [870, 867, 879, 874]
insert_ev_performer_to_event(idxs, ev_performers)

# 能(盲目之舞)「弱法師」
ev_performers = [74, 424, 867, 427, 457,
                 475, 108, 25, 154, 107,
                 26, 67, 157, 42, 15,
                 72]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/28 能の花　能を彩る花　第１回「菊」
# 能(酈縣山)「菊慈童」
ev_performers = [37, 424, 423, 414, 411,
                 421, 533, 427, 461, 485,
                 500, 39, 185, 60, 36,
                 179, 63, 180, 70, 144,
                 766, 1182]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/11/23 能の花　能を彩る花　第２回「紅葉」
# 能(紅葉ノ舞 群鬼ノ伝)「紅葉狩」
ev_performers = [222, 221, 201, 243, 261,
                 414, 412, 419, 426, 867,
                 869, 429, 464, 480, 501,
                 260, 238, 267, 591, 249,
                 271, 223, 215]
insert_ev_performer_to_event(idxs, ev_performers)

# 2018/1/23 能の花　能を彩る花　第3回「牡丹」
# 能(大獅子)「石橋」
ev_performers = [757, 1183, 424, 556, 839,
                 1000, 474, 491, 740, 800,
                 746, 185, 77, 786, 791,
                 63, 163, 70, 144]
insert_ev_performer_to_event(idxs, ev_performers)

# 2018/2/10 能の花　能を彩る花　第4回「梅」
# 能「東北」
ev_performers = [902, 407, 1184, 1185, 528,
                 447, 1130, 477, 920, 1186,
                 19, 16, 110, 25, 80,
                 93, 22, 68]
insert_ev_performer_to_event(idxs, ev_performers)

# 2018/3/10 能の花　能を彩る花　第５回「桜」
# 能「泰山府君」
ev_performers = [362, 818, 424, 541, 635,
                 454, 481, 497, 826, 823,
                 361, 827, 814, 822, 377,
                 812, 365, 376, 360]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/9/18 山本能楽堂90周年記念 とくい能　特別公演 卒都婆小町
# 能(一度之次第) 「卒都婆小町」
ev_performers = [929, 407, 982, 989, 1000,
                 1009, 934, 930, 941, 770,
                 942, 1052, 1073, 895, 762,
                 1187]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/1 一聲能
# 半能 「小鍛冶」
ev_performers = [1073, 835, 837, 1188, 1012,
                 1017, 934, 930, 941, 1052,
                 893, 1187]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/4 10月定例公演　仁王・龍田
# 狂言 「仁王」
ev_performers = [558, 559, 563, 538, 557,
                 537, 1189, 560]
insert_ev_performer_to_event(idxs, ev_performers)

# 能(移神楽) 「龍田」
ev_performers = [18, 422, 412, 420, 540,
                 839, 847, 479, 491, 889,
                 17, 15, 162, 95, 26,
                 46, 45, 161, 35]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/14 10月普及公演　泣尼・枕慈童
# 狂言 「泣尼」
ev_performers = [551, 548, 657]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 「枕慈童」
ev_performers = [404, 414, 421, 426, 435,
                 1128, 481, 727, 400, 391,
                 385, 384, 388, 401, 402,
                 405, 386, 390]
insert_ev_performer_to_event(idxs, ev_performers)

# 2017/10/20 10月定例公演　御茶の水・養老
# 狂言 「御茶の水」
ev_performers = [879, 861, 871]
insert_ev_performer_to_event(idxs, ev_performers)

# 能 (水波之伝) 「養老」
ev_performers = [123, 124, 1176, 986, 1185,
                  410, 635, 457, 487, 492,
                  125, 134, 109, 100, 99,
                  101, 122, 176, 50, 127,
                  187]
insert_ev_performer_to_event(idxs, ev_performers)
