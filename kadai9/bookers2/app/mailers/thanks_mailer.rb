class ThanksMailer < ApplicationMailer
	default :from => ENV['USER_NAME']

	def thanks_mail(user)
		@user = user
		mail( :to => @user.email, :subject => "会員登録が完了しました" )
	end
end
