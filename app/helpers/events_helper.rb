module EventsHelper

   # PublishedパラメータがtrueのEventのみ取得
   def public_events
      return Event.where(published: true)
   end
end
