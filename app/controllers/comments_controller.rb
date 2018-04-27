class CommentsController < ApplicationController
	# before_action :authenticate_user!

	def create
		if params[:account_id].present?
			@commentable = Account.find_by(id: params[:account_id])
		else
			@commentable = Team.find_by(id: params[:team_id])
			@account = Account.find_by(id: @commentable.account_id)
		end
		@comment = @commentable.comments.new(comment_params)
		@comment.user_id = current_user.id
		@comment.save
		if @account.present?
			redirect_to(account_team_path(@account, @commentable), :notice => 'Your comment was successfully posted')
		else
			redirect_to @commentable, notice: "Your comment was successfully posted"
		end	
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end