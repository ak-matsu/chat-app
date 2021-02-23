class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
  end

  #messagesコントローラーにcreateアクションを定義する
  def create
    # room_idから、特定のレコードを取得
    @room = Room.find(params[:room_id])
    # @room.messages.newでチャットルームに紐づいた
    #メッセージのインスタンスを生成し、属性値を指定
    @message = @room.messages.new(message_params)
    
    #メッセージを保存できた、できなかった場合を条件分岐
    if @message.save
      #redirect_toメソッドを用いてmessagesコントローラーのindexアクションに再度リクエストを送信し、新たにインスタンス変数を生成
      redirect_to  room_messages_path(@room)
    else
      #renderメソッドを用いてindexアクションのindex.html.erbを表示するように指定
      #indexアクションのインスタンス変数はそのままindex.html.erbに渡され、同じページに戻る
      render :index
    end
  end

  #privateメソッドとしてmessage_paramsを定義
  #メッセージの内容contentをmesessagesテーブルへ保存できるようにしている。
  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end