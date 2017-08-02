# frozen_string_literal: true

Ticket.delete_all

grade1 = ['前売券', '割引券', '学生券', '当日券', '正面券']
grade2 = ['後席', '2階席', 'ワキ見席', '正面席', '特等席']
grade3 = ['C席', 'B席', 'A席', 'S席', 'SS席']

grades = [grade1, grade2, grade3]

id_num = 1
event_id_num = 1
Event.all.each do |_event|
   timer = rand(1..5)
   grade = grades[rand(0..2)]
   init_price = rand(45..60)
   timer.times do |n|
      price = init_price * 100 + (n * rand(1..3) * 100)
      Ticket.seed do |s|
         s.id = id_num
         s.event_id = event_id_num
         s.grade = grade[n]
         s.price = price
      end
      id_num += 1
   end
   event_id_num += 1
end
