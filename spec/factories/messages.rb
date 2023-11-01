FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room
    # テスト用の画像ファイルを添付
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end