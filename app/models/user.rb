# frozen_string_literal: true

class User < ApplicationRecord
   has_many :user_events, dependent: :destroy
   has_many :events, through: :user_events

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w\d\-.]+\.[A-z]+\z/

   validates :name,        presence: true
   validates :email,       presence: true,
                           format: { with: VALID_EMAIL_REGEX },
                           uniqueness: { case_sensitive: false }
   validates :password,    presence: true,
                           allow_nil: true,
                           length: { minimum: 4 }
   has_secure_password
   # 利用規約に従う
   validates_acceptance_of :agreement, accpet: true,
                                       allow_nil: false,
                                       on: :create

   def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                          BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
   end
end
