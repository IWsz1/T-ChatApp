require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成することで自動的にusersテーブルとroomsテーブルのレコードも作成する
    @room_user = FactoryBot.create(:room_user)
    @message = FactoryBot.build(:message)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      expect{
        # クリック動作を行う 引数はvalue属性かリンクのテキスト名
        click_on("送信")
        # レコード追加に時間が掛かるケースがあるためテスト確認を1秒待機して待つ
        sleep 1
      #Userモデルに1行レコードが追加されたかを確認 
      }.not_to change { Message.count }
      # 元のページに戻ってくることを確認する
      expect(page).to have_current_path(room_messages_path(@room_user.room.id))
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する fill_inの後に入力したいフォームのラベル名orid名入れる
      fill_in "message_content",with:@message.content

      # 送信した値がDBに保存されていることを確認する
      expect{
        # クリック動作を行う引数はvalue属性かリンクのテキスト名
        click_on("送信")
        # レコード追加に時間が掛かるケースがあるためテスト確認を1秒待機して待つ
        sleep 1
      #Userモデルに1行レコードが追加されたかを確認 
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(page).to have_current_path(room_messages_path(@room_user.room.id))
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@message.content)

    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する 画像添付の際にパスの形として画像が必要となるため
      # rails.root.joinでアプリケーション名までの絶対パスを出してくれる（そのためファイルを指定できる）
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      # 第一引数にinputのname名、第二引数に添付したいファイルパス（ここまで必須)、第三引数では画像添付用のinput要素がdisplay:none担っているので一時的に表示可能へ変更するためのオプション
      attach_file('message[image]', image_path, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect{
        # クリック動作を行う引数はvalue属性かリンクのテキスト名
        click_on("送信")
        # レコード追加に時間が掛かるケースがあるためテスト確認を1秒待機して待つ
        sleep 1
      #Userモデルに1行レコードが追加されたかを確認 
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(page).to have_current_path(room_messages_path(@room_user.room.id))
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end

    it 'テキストと画像の投稿に成功する' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
      # 値をテキストフォームに入力する
      fill_in "message_content",with:@message.content
      # 送信した値がDBに保存されていることを確認する
      expect{
        # クリック動作を行う引数はvalue属性かリンクのテキスト名
        click_on("送信")
        # レコード追加に時間が掛かるケースがあるためテスト確認を1秒待機して待つ
        sleep 1
      #Userモデルに1行レコードが追加されたかを確認 
      }.to change { Message.count }.by(1)
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(@message.content)
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
  end
end