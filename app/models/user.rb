# frozen_string_literal: true

class User < ApplicationRecord
   attr_accessor :confirmation_token, :password_reset_token
   before_create :create_activation_digest

   has_many    :user_events,      dependent: :destroy
   has_many    :events,           through: :user_events
   has_many    :point_records,    dependent: :destroy
   has_many    :comments,         dependent: :destroy
   has_many    :bookmarks,        dependent: :destroy
   has_many    :bookmark_events,   class_name: 'Event',
                                  foreign_key: 'event_id',
                                  through:    :bookmarks

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w\d\-.]+\.[A-z]+\z/

   validates :name,        presence: true
   validates :email,       presence: true,
                           format: { with: VALID_EMAIL_REGEX },
                           uniqueness: { case_sensitive: false }
   validates :password,    presence: true,
                           allow_nil: true,
                           length: { minimum: 4 }
   has_secure_password
   validates :is_admin,    inclusion: { in: [true, false] }
   # 利用規約に従う
   validates_acceptance_of :agreement, accpet: true,
                                       allow_nil: false,
                                       on: :create

   def points
      return self.point_records.pluck(:point).inject(0) { |sum, p| sum + p }
   end

   def assign_bookmark(event)
      self.bookmarks.create(event_id: event.id)
   end

   def cancel_bookmark(event)
      bookmark = self.bookmarks.find_by(event_id: event.id)
      bookmark.destroy
   end

   def bookmarked?(event)
      return self.bookmark_events.include?(event)
   end

   def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                          BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
   end

   def self.create_token
      SecureRandom.urlsafe_base64
   end

   def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      if digest
         return BCrypt::Password.new(digest).is_password?(token)
      else
         return false
      end
   end

   def create_password_reset_token
      self.password_reset_token = User.create_token
      self.update_attributes!(password_reset_digest: User.digest(self.password_reset_token))
   end

   private
   def create_activation_digest
      self.confirmation_token = User.create_token
      self.confirmation_digest = User.digest(self.confirmation_token)
   end
end
