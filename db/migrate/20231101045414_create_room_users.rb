class CreateRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :room_users do |t|
      # 外部キーのカラム型　自動で外部キー制約がついている
      t.references :room
      t.references :user
      t.timestamps
    end
  end
end
