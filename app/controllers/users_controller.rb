class UsersController < ApplicationController
  def edit
    
  end

  #updateアクションをusersコントローラーに定義
  def update
    #updateアクション内で、保存できた、できなかった場合を条件分岐
    if  current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  #permitメソッドでname、emailの編集を許可
  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
