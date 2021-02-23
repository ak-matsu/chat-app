class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :rooms_users
end
