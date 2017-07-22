require 'rails_helper'

RSpec.describe User, type: :model do
   it "is valid with a name, email, information, and password" do
      user = User.new(name: 'Michael',
                      email: 'michael@gmail.com',
                      information: 'Nice to be with you.',
                      password: 'password',
                      password_confirmation: 'password',
                      agreement: true)
      expect(user).to be_valid
   end

   it "has many events" do
      assc_event = described_class.reflect_on_association(:events)
      expect(assc_event.macro).to eq(:has_many)
   end

   it "destroys associated events" do
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
      user.destroy
      expect(Event.where(id: event.id)).to be_empty
   end

   it "has many user_events" do
      assc_usr_ev = described_class.reflect_on_association(:user_events)
      expect(assc_usr_ev.macro).to eq(:has_many)
   end

   it "destroys associated user_events" do
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
      usr_ev = UserEvent.create(user_id: user.id,
                             event_id: event.id)
      user.destroy
      expect(UserEvent.where(id: usr_ev.id)).to be_empty
   end

   it "is invalid without a name" do
      user = User.new(name: nil)
      # REVIEW: なぜexpectメソッドの前にuser.validでuserがUserとして有効か
      # =>      検証する必要があるのか
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
   end

   it "is invalid without an email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
   end

   it "is invalid with an improper email" do
      invalid_emails = ["user@example,com",
                        "gabriel_yahoo_co_jp",
                        "mon_key@+oh@foo.com"]
      invalid_emails.each do |invalid_email|
         user = User.new(email: invalid_email)
         user.valid?
         expect(user.errors[:email]).to include('is invalid')
      end
   end

   it "is invalid with a duplicate email address" do
      User.create(name: 'Michael',
                  email: 'michael@gmail.com',
                  information: 'Nice to be with you.',
                  password: 'password',
                  password_confirmation: 'password',
                  agreement: true)
      user = User.new(name: 'Gabriel',
                      email: 'michael@gmail.com',
                      information: 'Nice to see you.',
                      password: 'password',
                      password_confirmation: 'password',
                      agreement: true)
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
   end

   it "is invalid without a password" do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
   end

   it "isn't accepted authentication of password confirmation" do
      user = User.new(password: 'password', password_confirmation: 'drowssap')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
   end

   it "is invalid with a less than 4 character-password" do
      user = User.new(password: 'pas', password_confirmation: 'pas')
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 4 characters)')
   end

   it "is created when a new user agreed a terms and service" do
      user = User.new(agreement: false)
      user.valid?
      expect(user.errors[:agreement]).to include('must be accepted')
   end
end
