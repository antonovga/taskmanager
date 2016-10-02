class User < ApplicationRecord
  extend Enumerize

  enumerize :role, in: { user: 0, admin: 1 }, scope: true, predicates: { prefix: true }

  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self[:password] = nil
    elsif !unencrypted_password.empty?
      self[:password] = BCrypt::Password.create(unencrypted_password, cost: BCrypt::Engine.cost)
    end
  end
end
