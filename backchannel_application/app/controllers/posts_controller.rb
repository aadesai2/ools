class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @posts = Post.find(params[:id])
  end

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(params[:post])

  if(current_user)
    @post.user_id = current_user.username
  end
    cat = Category.find name:'test1'
    @post.category_id = cat.cid
    if @post.save
      redirect_to posts_path , :notice => "Your post was saved successfully."
    else
      render "new"
    end
  end

  def edit
    @post =Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if (current_user)
      if(current_user.username == @post.user_id)
        edi = 1
      end
    end
    if(current_user.is_admin == 1)
      edi = 1
    end
    if(edi == 1)
    if @post.update_attributes(params[:post])
      redirect_to posts_path, :notice => "Your post was updated successfully"
    else
      render "edit"
    end
    else
      redirect_to posts_path, :notice => "You can edit only your posts"
    end
    edi = 0
  end

  def destroy
    @post = Post.find(params[:id])
  if (current_user)
    if(current_user.username == @post.user_id)
       del = 1
    end
  end
    if(current_user.is_admin == 1)
      del = 1
    end
    if(del == 1)
    @post.destroy
    redirect_to posts_path, :notice => "Your post was updated successfully"
    else
      redirect_to posts_path, :notice => "You can only delete your posts"
    end
    del = 0
  end

end

