class Room < ApplicationRecord
  # roomを消した時にmessagesとroomusersも自動で消えるように設定
  # これがないと外部キー制約の子要素を消せてないと親用を消せないと言う制約に引っかかってしまう
  has_many :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  # 多対多用のアソシエーション設定+中間テーブル名の記載
  has_many :users, through: :room_users
end
