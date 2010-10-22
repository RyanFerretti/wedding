class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if current_user
      params[:comment][:author] = current_user.first_name 
    end
    @comment = @post.comments.create(params[:comment])
    respond_to do |format|
      format.html { redirect_to @post }
      format.js   {
        if @comment.new_record?
          render :action => 'errors'
        else
          render :action => 'create'
        end
      }
    end
  end
end
