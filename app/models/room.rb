class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  #throughオプションはモデルに多対多の関連を定義するときに使う。
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
