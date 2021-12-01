class Room < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :rooms, dependent: :destroy
end
