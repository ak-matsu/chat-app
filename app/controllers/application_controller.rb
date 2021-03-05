class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #ログインしていないユーザーをログインページの画面に促すことができる。

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    #devise_parameter_sanitizerとはdeviseでユーザー登録をする場合に使用でき、
    # 「特定のカラムを許容する」メソッド
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #nameカラムを追加、nameキーの内容の保存を.permitメソッドで許可している。
  end

end
