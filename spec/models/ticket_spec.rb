require 'rails_helper'

RSpec.describe Ticket, type: :model do
=begin
   it "is valid with event_id, grade, and price" do
      user = User.create(name: 'Michael',
                         email: 'michael@gmail.com',
                         information: 'Nice to be with you.',
                         password: 'password',
                         password_confirmation: 'password',
                         agreement: true)
      place = Place.create(title: 'Temple',
                           address: 'kyoto',
                           official_url: 'http://www.temple.com')

      event = Event.create(place_id: place.id,
                           title: 'First Event',
                           start_date: Date.today,
                           end_date: Date.today + 1,
                           information: 'It will be the best event for you!',
                           official_url: 'http://www.firstevent.com',
                           user_id: user.id,
                           published: true)

      ticket = Ticket.new(event_id: event.id,
                          grade: 'Business class',
                          price: 7000)
      expect(ticket).to be_valid
   end

   it "is invalid without an event_id" do
      ticket = Ticket.new(event_id: nil)
      ticket.valid?
      expect(ticket.errors[:event_id]).to include ("can't be blank")
   end

   it "is invalid without a grade" do
      ticket = Ticket.new(event_id: nil)
      ticket.valid?
      expect(ticket.errors[:grade]).to include ("can't be blank")
   end

   it "is invalid without a price" do
      ticket = Ticket.new(event_id: nil)
      ticket.valid?
      expect(ticket.errors[:price]).to include ("can't be blank")
   end
=end
end
