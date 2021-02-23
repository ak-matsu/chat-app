class Message < ApplicationRecord

  belongs_to :room #一つのメッセージは、一つのルームに存在する。
  belongs_to :user #一つのメッセージは、一つのユーザから送信される。

  validates :content, presence: true
  #「content」カラムに、presence: trueを設けることで、
  #空の場合はDBに保存しないというバリデーションを設定
end
