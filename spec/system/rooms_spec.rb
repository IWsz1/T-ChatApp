require 'rails_helper'

RSpec.describe 'チャットルームの削除機能', type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されている' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    # 第一引数にテーブル名、第二引数に追加個数、第三引数以降にカラム名に対して指定があれば記載
    FactoryBot.create_list(:message, 5,room_id: @room_user.room.id, user_id: @room_user.user.id)
    # 再度チャットルームの画面を表示してメッセージが追加されたことを目視確認
    visit room_messages_path(@room_user.room.id)

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect {
      click_on("チャットを終了する")
      sleep 1
    }.to change { @room_user.room.messages.count }.by(-5)
    # トップページに遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end
end