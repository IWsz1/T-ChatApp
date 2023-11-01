class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # was_attachedがfalse(画像がない)とcontentが必要なバリデーション
  validates :content,presence:true,unless: :was_attached?
  # has_one_attachedで1つのレコードに1つのファイル(image)を添付できる
  # ファイル名がモデルと紐づいたフォームから送られてくるフォルダのキーになる
  # この仕組みでmessageレコードに画像を添付する
  # カラムの設定は必要ない
  has_one_attached :image
  #画像が添付されていたらtrueを返すメソッド 
  def was_attached?
    self.image.attached?
  end
end
