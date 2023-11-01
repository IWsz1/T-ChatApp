class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :name,presence:true, length:{maximum:6}
end
