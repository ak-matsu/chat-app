class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  #どのルームを削除するのか特定したい場合、Room.find(params[:id])を使用
  def destroy
    room = Room.find(params[:id])
    room.destroy
    #destroyメソッドが実行されたらrootにリダイレクトする
    redirect_to root_path
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end
