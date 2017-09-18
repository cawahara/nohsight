EventPerformer.create!([
   # title: 夕暮れ能
   ['金剛 龍謹', '岡 充', '森田 保美', '曽和 鼓堂', '谷口 正壽', '前川 光範', '豊嶋 晃嗣', '山田 伊純', '豊嶋 幸洋', '今井 克紀',
    '宇髙 竜成', '重本 昌也', '宇髙 徳成', '向井 弘記'].each do |performer|
      {event_program_id: EventProgram.find_by(event_id: Event.find_by(title: '夕暮れ能', start_date: '2017-09-08 17:00:00').id, program_id: Program.find_by(title: '羽衣').id).id,
      performer_id: Performer.find_by(full_name: performer).id}
   end

])
