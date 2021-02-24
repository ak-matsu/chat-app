class Message < ApplicationRecord

  belongs_to :room #一つのメッセージは、一つのルームに存在する。
  belongs_to :user #一つのメッセージは、一つのユーザから送信される。
  has_one_attached :image
  #has_one_attachedメソッドを記述したモデルの各レコードは、それぞれ1つのファイルを添付


  #「content」カラムに、presence: trueを設けることで、
  #空の場合はDBに保存しないというバリデーションを設定
  #unless:オプションにメソッド名を指定、メソッドの返り値がfalseならバリデーションを行う
  validates :content, presence: true, unless: :was_attached?

  #was_attached?メソッドはself.image.attached?という記述により
  #画像があればtrue,なければfalseとなる。
  #これにより画像がなければテキストが必要となり、画像があればテキストは不要となった。
  def was_attached?
    self.image.attached?
  end
end
