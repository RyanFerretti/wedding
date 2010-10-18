class PostAttachmentsController < ApplicationController
  def index       
    @post = Post.find(params[:post_id])

  end

  def create
    @post = Post.find(params[:post_id])
    @post_attachment = @post.post_attachments.create(params[:post_attachment])
    if @post_attachment.save
      flash[:notice] = "Successfully created post attachment."
      redirect_to post_post_attachments_path(@post)
    end
  end
end
