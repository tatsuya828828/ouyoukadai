class PostCommentsController < ApplicationController

	def create
		book = Book.find(params[:book_id])
		#comment = PostComment.new(post_comment_params)
		#comment.user_id = current_user.id
		comment = current_user.post_comments.new(post_comment_params)
		# ↑ 上の2行を省略して書いたもの
		comment.book_id = book.id
		if comment.save
			redirect_back(fallback_location: root_path)
		else
			book = Book.find(params[:book_id])
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		comment = PostComment.find(params[:id])
		comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def post_comment_params
		params.require(:post_comment).permit(:comment)
	end

end
