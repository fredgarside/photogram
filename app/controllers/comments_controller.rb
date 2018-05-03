class CommentsController < ApplicationController

before_action :set_post

def create
  @comment = @post.comments.build(comment_params)
  @comment.user_id = current_user.id

  if @comment.save
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  else
    flash[:alert] = "Check the comment form, something went horribly wrong."
    render root_path
  end
end

def destroy

  @comment = @post.comments.find(params[:id])

  if @comment.user_id == current_user.id
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = "Post could not be deleted!"
    end
  else 
    flash[:alert] = "You can not delete other peoples comments!"
  end
end

private

def comment_params
  params.require(:comment).permit(:context)
end

def set_post
  @post = Post.find(params[:post_id])
end

end
