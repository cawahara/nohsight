# frozen_string_literal: true

id = 12
event_id = 12
idxs = [id, event_id]

def insert_ticket_to_event(idxs, tickets)
   id = idxs[0]
   event_id = idxs[1]

   tickets.each do |ticket|
     grade = ticket[0]
     price = ticket[1]
     Ticket.seed do |s|
        s.id = id
        s.event_id = event_id
        s.grade = grade
        s.price = price
     end
      id += 10
   end
   event_id += 10

   idxs[0] = id
   idxs[1] = event_id
end

# 2017/9/8 夕暮れ能
tickets = [['一般', 0]]
insert_ticket_to_event(idxs, tickets)

# 2017/9/24 第七回 金剛定期能
tickets = [['前売', 5500], ['当日', 6000],
             ['学生', 3000]]
insert_ticket_to_event(idxs, tickets)

# 2017/11/18 東京金剛界 第四回例会能
tickets = [['一般', 5000], ['当日', 3000]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/8 種田後演会能
tickets = [['前売(予定)', 8000], ['当日', 9000],
           ['学生', 4000]]
insert_ticket_to_event(idxs, tickets)

# 2017/8/16 第15回 大文字送り火能 ～蝋燭能～
tickets = [['一般', 5000], ['学生', 3000]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/1 金沢能楽会定期能
tickets = [['前売', 2500], ['当日', 3000],
           ['学生(高校生以上)', 1000], ['学生(中学生以下)', 0]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/12 観世会荒磯能
tickets = [['前売', 3150], ['当日', 4200],
           ['学生', 1570]]
insert_ticket_to_event(idxs, tickets)

# 2017/09/02 浦田定期能
tickets = [['前売', 3500], ['当日', 4000],
           ['学生', 2000]]
insert_ticket_to_event(idxs, tickets)

# 2017/09/24 京都観世会九月例会
tickets = [['前売', 6000], ['当日', 6500],
           ['学生', 3000]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/15 第３４回　横浜かもんやま能
tickets = [['S席', 4000], ['A席', 3500],
           ['B席', 3000]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/28 能の花　能を彩る花　第１回「菊」
tickets = [['S席', 7000], ['A席', 6000],
           ['B席', 5000]]
insert_ticket_to_event(idxs, tickets)

# 2017/11/23 能の花　能を彩る花　第２回「紅葉」
tickets = [['S席', 7000], ['A席', 6000],
           ['B席', 5000]]
insert_ticket_to_event(idxs, tickets)

# 2018/1/23 能の花　能を彩る花　第3回「牡丹」
tickets = [['S席', 7000], ['A席', 6000],
           ['B席', 5000]]
insert_ticket_to_event(idxs, tickets)

# 2018/2/10 能の花　能を彩る花　第4回「梅」
tickets = [['S席', 7000], ['A席', 6000],
           ['B席', 5000]]
insert_ticket_to_event(idxs, tickets)

# 2018/3/10 能の花　能を彩る花　第５回「桜」
tickets = [['S席', 7000], ['A席', 6000],
           ['B席', 5000]]
insert_ticket_to_event(idxs, tickets)

# 2017/9/18 山本能楽堂90周年記念 とくい能　特別公演 卒都婆小町
tickets = [['一般前売', 4500], ['一般当日', 5500]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/1 一聲能
tickets = [['前売', 3000], ['当日', 4000]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/4 10月定例公演　仁王・龍田
tickets = [['正面', 4900], ['脇正面', 3200],
           ['中正面', 2700], ['脇正面(学生)', 2200],
           ['中正面(学生)', 1900]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/14 10月普及公演　泣尼・枕慈童
tickets = [['正面', 4900], ['脇正面', 3200],
           ['中正面', 2700], ['脇正面(学生)', 2200],
           ['中正面(学生)', 1900]]
insert_ticket_to_event(idxs, tickets)

# 2017/10/20 10月定例公演　御茶の水・養老
tickets = [['正面', 4900], ['脇正面', 3200],
           ['中正面', 2700], ['脇正面(学生)', 2200],
           ['中正面(学生)', 1900]]
insert_ticket_to_event(idxs, tickets)
