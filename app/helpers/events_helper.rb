module EventsHelper

   # PublishedパラメータがtrueのEventのみ取得(不特定多数が公演場を見るときの必須条件)
   def public_events(events)
      return events.where(published: true)
   end

   # 本日以降の未開催のイベントを表示
   def upcoming_events(events)
      return events.where('published = ? AND start_date >= ?', true, Date.today).order(:start_date).reverse_order
   end
end
