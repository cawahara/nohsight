# frozen_string_literal: true

module CRUDEvent
   extend ActiveSupport::Concern

   def create_event
      begin
         params_valid?
         ActiveRecord::Base.transaction do
            event = initialize_event(false, 'create')
            update_event_programs(event)
            update_tickets(event)
            event.user_events.create!(user: current_user, organizer: true)
            return event
         end
      rescue ActiveRecord::RecordInvalid
         return false
      end
   end

   def update_event(event)
      begin
         params_valid?
         ActiveRecord::Base.transaction do
            event = initialize_event(event, 'update')
            update_event_programs(event)
            update_tickets(event)
         end
         return event
      rescue ActiveRecord::RecordInvalid
         return false
      end
   end

   def initialize_event(event, mode)
      if @event_params[:place_id] == '0'
         @event_params[:place_id] = create_place
      end
      if mode == 'create'
         begin
            original_ev = Event.find(params[:id])
            event = original_ev.editions.create!(@event_params)
         rescue ActiveRecord::RecordNotFound
            event = Event.create!(@event_params)
         end
      else
         event.update_attributes!(@event_params)
      end
      return event
   end

   def update_event_programs(event)
      @event_programs_params.values.each do |ev_program_params|
         if ev_program_params[:program_id] == '0'
            ev_program_params[:program_id] = create_program(ev_program_params[:title])
         end
         ev_program_params_for_init = { program_id: ev_program_params[:program_id],
                                        genre: ev_program_params[:genre] }
          ev_program = EventProgram.find(ev_program_params[:id]) if ev_program_params[:mode] != 'create'
          case ev_program_params[:mode]
          when 'create'
             ev_program = event.event_programs.create!(ev_program_params_for_init)
          when 'update'
             ev_program.update_attributes!(ev_program_params_for_init)
          when 'destroy'
             ev_program.destroy!
             next
          end
         update_event_performers(ev_program, ev_program_params[:event_performers])
      end
   end

   def update_event_performers(ev_program, event_performers_params)
      event_performers_params.values.each do |ev_performer_params|
         if ev_performer_params[:performer_id] == '0'
            ev_performer_params[:performer_id] = create_performer(ev_performer_params[:full_name])
         end
         ev_performer_params_for_init = { performer_id: ev_performer_params[:performer_id] }
         ev_performer = EventPerformer.find(ev_performer_params[:id]) if ev_performer_params[:mode] != 'create'
         case ev_performer_params[:mode]
         when 'create'
            ev_program.event_performers.create!(ev_performer_params_for_init)
         when 'update'
            ev_performer.update_attributes!(ev_performer_params_for_init)
         when 'destroy'
            ev_performer.destroy!
         end
      end
   end

   def update_tickets(event)
      @tickets_params.values.each do |ticket_params|
         ticket_params_for_init = { grade: ticket_params[:grade],
                                    price: ticket_params[:price] }
         ticket = Ticket.find(ticket_params[:id]) if ticket_params[:mode] != 'create'
         case ticket_params[:mode]
         when 'create'
            event.tickets.create!(ticket_params_for_init)
         when 'update'
            ticket.update_attributes!(ticket_params_for_init)
         when 'destroy'
            ticket.destroy!
         end
      end
   end

   # マスターデータ用
   def create_place
      place = Place.find_or_initialize_by(title: @place_params[:title]) do |place|
         place.address = @place_params[:address]
         place.official_url = @place_params[:official_url]
      end
      if place.valid?
         place.save
         return place.id
      else
         @error_msgs[:place] = place.errors.messages
         @invalid_occured = true
         return 0
      end
   end

   def create_program(program_title, ev_program_error = nil)
      program = Program.find_or_initialize_by(title: program_title)
      if program.valid?
         program.save
         return program.id
      else
         ev_program_error[:title] = program.errors.messages[:title]
         @invalid_occured = true
         return nil
      end
   end

   def create_performer(performer_full_name, ev_performer_error = nil)
      performer = Performer.find_or_initialize_by(full_name: performer_full_name)
      if performer.valid?
         performer.save
         return performer.id
      else
         ev_performer_error[:full_name] = performer.errors.messages[:full_name]
         @invalid_occured = true
         return nil
      end
   end

   def params_valid?
      @invalid_occured = false
      validated_event = Event.new(@event_params)
      validated_event.place_id = create_place
      unless validated_event.valid?
         @error_msgs[:event] = validated_event.errors.messages
         @invalid_occured = true
      end
      ev_programs_msgs = 0
      @error_msgs[:event_programs] = {}
      @event_programs_params.values.each do |ev_program_params|
         ev_program_error = {}
         ev_program = EventProgram.new(event_id: 0, program_id: create_program(ev_program_params[:title], ev_program_error), genre: ev_program_params[:genre])

         ev_performers_msgs = 0
         ev_program_params[:event_performers].values.each do |ev_performer_params|
            ev_performer_error = {}
            ev_performer = EventPerformer.new(event_program_id: 0, performer_id: create_performer(ev_performer_params[:full_name], ev_performer_error))
            ev_program_error[:event_performers] ||= {}
            ev_program_error[:event_performers][:"#{ev_performers_msgs}"] = ev_performer_error
            ev_performers_msgs += 1
         end
         unless ev_program.valid?
             @invalid_occured = true
             ev_program_error.merge!(ev_program.errors.messages)
         end
         @error_msgs[:event_programs][:"#{ev_programs_msgs}"] = ev_program_error
         ev_programs_msgs += 1
      end

      tickets_msgs = 0
      @tickets_params.values.each do |ticket_params|
         ticket_error = {}
         ticket = Ticket.new(event_id: 0, grade: ticket_params[:grade], price: ticket_params[:price])
         @error_msgs[:tickets] ||= {}
         @invalid_occured = true unless ticket.valid?
         @error_msgs[:tickets][:"#{tickets_msgs}"] = ticket.errors.messages
         tickets_msgs += 1
      end
      raise ActiveRecord::RecordInvalid if @invalid_occured == true
   end
end
