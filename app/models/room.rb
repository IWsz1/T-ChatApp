class Room < ApplicationRecord
  has_many :room_users
  # 多対多用のアソシエーション設定+中間テーブル名の記載
  has_many :users, through: :room_users
end
