class ChatsController < ApplicationController
	before_action :authenticate_user!

	def create
		if UserRoom.where(:user_id => current_user.id, :room_id => params[:chat][:room_id]).present?
			@chat = Chat.create(params.require(:chat).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
			redirect_to "/chats/#{@chat.room_id}"
		else
			redirect_back(fallback_location: root_path)
		end
	end

	def show
		@room = Room.find(params[:id])
		if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
			@chats = @room.chats
			@chat = Chat.new
			@userRooms = @room.user_rooms
		else
			redirect_back(fallback_location: root_path)
		end
	end
end
