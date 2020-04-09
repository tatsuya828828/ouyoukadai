class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super do
      resource.update(confirmed_at: Time .now.utc)

      @user = User.new(user_params)
      if @user.save
        log_in @user
        UserNotifierMailer.send_signup_email(@user).deliver
        redirect_to @user
      else
        render "new"
      end
    end
  end
end