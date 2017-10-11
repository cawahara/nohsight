# frozen_string_literal: true

class User < ApplicationRecord
   has_many :user_events, dependent: :destroy
   has_many :events, through: :user_events
   has_many :point_records, dependent: :destroy
   has_many :comments,      dependent: :destroy

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

   def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                          BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
   end
end
