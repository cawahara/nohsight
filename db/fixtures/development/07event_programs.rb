# frozen_string_literal: true

id = 1
event_id = 1
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
      id += 1
   end
   event_id += 1

   idxs[0] = id
   idxs[1] = event_id
end

# 2017/9/8 夕暮れ能
ev_programs = [[191, '仕舞(ｸｾ)'], [149, '仕舞'],
               [153, '能(盤渉)'], [79, '半能(白頭)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/9/24 第七回 金剛定期能
ev_programs = [[15, '仕舞(ｷﾘ)'], [158, '仕舞(ｸﾙｲ)'],
               [69, '仕舞'], [90, '能'],
               [220, '狂言'], [143, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/11/18 東京金剛界 第四回例会能
ev_programs = [[79, '研修能'], [130, '能'], [54, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/8 種田後演会能
ev_programs = [[109, '能(女体)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/8/16 第15回 大文字送り火能 ～蝋燭能～
ev_programs = [[57, '能(替装束)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/1 金沢能楽会定期能
ev_programs = [[154, '能'], [221, '狂言'],
               [130, '仕舞(ｸｾ)'], [3, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/12 観世会荒磯能
ev_programs = [[8, '仕舞(ｷﾘ)'], [51, '仕舞(ｸｾ)'],
               [58, '仕舞(楽ｱﾄ)'], [200, '能'],
               [222, '狂言'], [107, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/09/02 浦田定期能
ev_programs = [[204, '能'], [150, '素謡'],
               [223, '狂言'], [37, '仕舞'],
               [144, '仕舞'], [178, '仕舞'],
               [26, '仕舞'], [49, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/09/24 京都観世会九月例会
ev_programs = [[192, '能'], [224, '狂言'],
               [195, '能'], [8, '仕舞(ｷﾘ)'],
               [200, '仕舞'], [109, '仕舞'],
               [55, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/15 第３４回　横浜かもんやま能
ev_programs = [[225, '狂言'], [205, '能(盲目之舞)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/28 能の花　能を彩る花　第１回「菊」
ev_programs = [[219, '能(酈縣山)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/11/23 能の花　能を彩る花　第２回「紅葉」
ev_programs = [[191, '能(紅葉ノ舞 群鬼ノ伝)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2018/1/23 能の花　能を彩る花　第3回「牡丹」
ev_programs = [[92, '能(大獅子)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2018/2/10 能の花　能を彩る花　第4回「梅」
ev_programs = [[139, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2018/3/10 能の花　能を彩る花　第５回「桜」
ev_programs = [[115, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/9/18 山本能楽堂90周年記念 とくい能　特別公演 卒都婆小町
ev_programs = [[113, '能(一度之次第)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/1 一聲能
ev_programs = [[79, '半能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/4 10月定例公演　仁王・龍田
ev_programs = [[226, '狂言'], [120, '能(移神楽)']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/14 10月普及公演　泣尼・枕慈童
ev_programs = [[227, '狂言'], [177, '能']]
insert_ev_program_to_event(idxs, ev_programs)

# 2017/10/20 10月定例公演　御茶の水・養老
ev_programs = [[228, '狂言'], [202, '能(水波之伝)']]
insert_ev_program_to_event(idxs, ev_programs)
