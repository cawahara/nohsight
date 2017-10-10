# frozen_string_literal: true

module SetVariablesOnEventsController
   extend ActiveSupport::Concern

   # This module is for returing variables that are put onto each corresponding form
   # when one of the following actions is executed(create and update are executed when
   # they are failed to update relative datas and render an action with get request)

   def values_on_edit(mode)
      @event_params ||= { id:              @event&.id,
                        title:             @event&.title,
                        open_date:           @event&.open_date,
                        start_date:          @event&.start_date,
                        category:            @event&.category,
                        information:         @event&.information,
                        official_url:        @event&.official_url,
                        publishing_status:   @event&.publishing_status,
                        place_id:            @event&.place_id }
      @place_params ||= { title:        @event.place&.title,
                        address:      @event.place&.address,
                        official_url: @event.place&.official_url }

      @event_programs_params = {}
      @event.event_programs.each_with_index do |ev_program, program_idx|
         @event_performers_params = {}
         ev_program.event_performers.each_with_index do |ev_performer, performer_idx|
            @event_performers_params[:"#{performer_idx}"] = { id:           ev_performer.id,
                                                              performer_id: ev_performer.performer_id,
                                                              full_name:    ev_performer.performer.full_name,
                                                              mode:         mode }
         end
         @event_performers_params = { '0': { id: nil, performer_id: nil, full_name: nil, mode: mode } } if ev_program.event_performers.count == 0
         @event_programs_params[:"#{program_idx}"] = { id:               ev_program.id,
                                                       program_id:       ev_program.program_id,
                                                       title:            ev_program.program.title,
                                                       genre:            ev_program.genre,
                                                       event_performers: @event_performers_params,
                                                       mode:             mode }
      end
      if @event.event_programs.count == 0
         @event_performers_params = { '0': { id: nil, performer_id: nil, full_name: nil, mode: mode } }
         @event_programs_params = { '0': { id: nil, program_id: nil, title: nil, genre: nil, event_performers: @event_performers_params, mode: mode } }
      end

      @tickets_params = {}
      @event.tickets.each_with_index do |ticket, idx|
         @tickets_params[:"#{idx}"] = { id:    ticket&.id,
                                        grade: ticket&.grade,
                                        price: ticket&.price,
                                        mode:  mode }
      end
      @tickets_params = { '0': { id: nil, grade: nil, price: nil, mode: mode } } if @event.tickets.count == 0
      @error_msgs ||= {}
   end
end
