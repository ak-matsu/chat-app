class Message < ApplicationRecord

  belongs_to :room #一つのメッセージは、一つのルームに存在する。
  belongs_to :user #一つのメッセージは、一つのユーザから送信される。

end
