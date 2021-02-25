FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    #after(:build)とすることでインスタンスがbulidされた後に指定の処理を実行できます。
    #.attachとは中にイメージデータが入っているか判別している。
    #io: File.openで設定したパスのファイルをtest_image.pngで保存している。
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end