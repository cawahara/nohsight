# frozen_string_literal: true

module EventsHelper
   # PublishedパラメータがtrueのEventのみ取得(不特定多数が公演場を見るときの必須条件)
   def public_events(events)
      return events.where(published: true)
   end

   # 本日以降の未開催のイベントを表示
   def upcoming_events(events)
      query = 'published = ? AND start_date >= ?'
      return events.where(query, true, Date.today).order(start_date: :desc)
   end

   class ActiveSupport::TimeWithZone
      WEEKDAYS = ['日', '月', '火', '水', '木', '金', '土']

      def format_with_weekday
         weekday = WEEKDAYS[self.wday]
         self.strftime("%Y/%m/%d %H:%M (#{weekday}曜日)")
      end
   end
end
