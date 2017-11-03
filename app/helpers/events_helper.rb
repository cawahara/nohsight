# frozen_string_literal: true

module EventsHelper
   # publishing_statusパラメータが3(published)のEventのみ取得(不特定多数が公演場を見るときの必須条件)
   def public_events(events)
      return events.where(publishing_status: 3)
   end

   # 本日以降の未開催のイベントを表示
   def upcoming_events(events)
      query = 'publishing_status = ? AND start_date >= ?'
      return events.where(query, 3, Date.today).order(start_date: :desc)
   end

   class ActiveSupport::TimeWithZone
      WEEKDAYS = ['日', '月', '火', '水', '木', '金', '土']

      def with_formats(*units)
         datetime_format = ''
         units.each do |unit|
            case unit
            when 'date'
               datetime_format += "%Y/%m/%d "
            when 'time'
               datetime_format += "%H:%M "
            when 'weekday'
               datetime_format += "(#{WEEKDAYS[self.wday]}曜日) "
            else
               datetime_format += ""
            end
         end
         return self.strftime(datetime_format)
      end
   end

   # on form action (new or edit)
   def show_errors_on_form(error_msgs)
      begin
         error_msgs = error_msgs.map.with_index { |msg, i| msg = i < error_msgs.count - 1 ? msg + ', ' : msg }
         return error_msgs.join("")
      rescue NoMethodError
         return ''
      end
   end
end
