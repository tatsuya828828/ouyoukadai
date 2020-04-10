class ApplicationController < ActionController::Base
	before_action :authenticate_user!, except: [:top,:about,:sign_up,:sign_in]
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception
  protected

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email,:postal_code,:prefecture_code,:city,:street])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end
  private

end