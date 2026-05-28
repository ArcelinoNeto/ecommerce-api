# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum profile: { customer: 1, admin: 2 }

  has_many :orders, dependent: :restrict_with_error

  def as_json(options = {})
    super({
      only: %i[id name email profile created_at updated_at]
    }.merge(options))
  end
end
