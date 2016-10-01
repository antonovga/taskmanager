class User < ApplicationRecord
  extend Enumerize

  enumerize :role, in: { user: 0, admin: 1 }, scope: true, predicates: { prefix: true }

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end