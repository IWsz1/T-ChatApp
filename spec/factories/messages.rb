FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room
    # テスト用の画像ファイルを添付
    after(:build) do |message|
      # imageに対してio:file.openで開いた箇所にあるファイルをtest_image.pngというファイル名で保存する
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end