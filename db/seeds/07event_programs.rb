EventProgram.create!([
   # title: 夕暮れ能
   {event_id: Event.find_by(title: '夕暮れ能', start_date: '2017-09-08 17:00:00').id, program_id: Program.find_by(title: '羽衣').id, genre: '能'},
   {event_id: Event.find_by(title: '夕暮れ能', start_date: '2017-09-08 17:00:00').id, program_id: Program.find_by(title: '小鍛冶').id, genre: '能'},
])
