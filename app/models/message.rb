class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content,presence:true
  # has_one_attachedで1つのレコードに1つのファイル(image)を添付できる
  # ファイル名がモデルと紐づいたフォームから送られてくるフォルダのキーになる
  # この仕組みでmessageレコードに画像を添付する
  # カラムの設定は必要ない
  has_one_attached :image
end
