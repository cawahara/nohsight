# frozen_string_literal: true

id = 12
event_id = 12
idxs = [id, event_id]

def insert_ev_program_to_event(idxs, ev_programs)
   id = idxs[0]
   event_id = idxs[1]

   ev_programs.each do |ev_program|
     program_id = ev_program[0]
     genre = ev_program[1]
     EventProgram.seed do |s|
        s.id = id
        s.event_id = event_id
        s.program_id = program_id
        s.genre = genre
     end
      id += 10
   end
   event_id += 10

   idxs[0] = id
   idxs[1] = event_id
end

# 2017/9/8 夕暮れ能
ev_programs = [[1912, '仕舞(ｸｾ)'], [1492, '仕舞'],
               [1532, '能(盤渉)'], [792, '半能(白頭)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/9/24 第七回 金剛定期能
ev_programs = [[152, '仕舞(ｷﾘ)'], [1582, '仕舞(ｸﾙｲ)'],
               [692, '仕舞'], [902, '能'],
               [2202, '狂言'], [1432, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/11/18 東京金剛界 第四回例会能
ev_programs = [[792, '研修能'], [1302, '能'], [542, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/8 種田後演会能
ev_programs = [[1092, '能(女体)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/8/16 第15回 大文字送り火能 ～蝋燭能～
ev_programs = [[572, '能(替装束)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/1 金沢能楽会定期能
ev_programs = [[1542, '能'], [2212, '狂言'],
               [1302, '仕舞(ｸｾ)'], [32, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/12 観世会荒磯能
ev_programs = [[82, '仕舞(ｷﾘ)'], [512, '仕舞(ｸｾ)'],
               [582, '仕舞(楽ｱﾄ)'], [2002, '能'],
               [2222, '狂言'], [1072, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/09/02 浦田定期能
ev_programs = [[2042, '能'], [1502, '素謡'],
               [2232, '狂言'], [372, '仕舞'],
               [1442, '仕舞'], [1782, '仕舞'],
               [262, '仕舞'], [492, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/09/24 京都観世会九月例会
ev_programs = [[1922, '能'], [2242, '狂言'],
               [1952, '能'], [82, '仕舞(ｷﾘ)'],
               [2002, '仕舞'], [1092, '仕舞'],
               [552, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/15 第３４回　横浜かもんやま能
ev_programs = [[2252, '狂言'], [2052, '能(盲目之舞)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/28 能の花　能を彩る花　第１回「菊」
ev_programs = [[2192, '能(酈縣山)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/11/23 能の花　能を彩る花　第２回「紅葉」
ev_programs = [[1912, '能(紅葉ノ舞 群鬼ノ伝)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2018/1/23 能の花　能を彩る花　第3回「牡丹」
ev_programs = [[922, '能(大獅子)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2018/2/10 能の花　能を彩る花　第4回「梅」
ev_programs = [[1392, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2018/3/10 能の花　能を彩る花　第５回「桜」
ev_programs = [[1152, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/9/18 山本能楽堂90周年記念 とくい能　特別公演 卒都婆小町
ev_programs = [[1132, '能(一度之次第)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/1 一聲能
ev_programs = [[792, '半能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/4 10月定例公演　仁王・龍田
ev_programs = [[2262, '狂言'], [1202, '能(移神楽)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/14 10月普及公演　泣尼・枕慈童
ev_programs = [[2272, '狂言'], [1772, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/20 10月定例公演　御茶の水・養老
ev_programs = [[2282, '狂言'], [2022, '能(水波之伝)']]
insert_ev_program_to_event(idxs, ev_programs)
