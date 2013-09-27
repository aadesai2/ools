class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def vote (postID)

    @po = Post.find(postID)

    if(current_user)
      if @po.user_id == current_user.username
        redirect_to posts_path , :notice => "You cannot vote up your own post."
        return
      end
    else
      redirect_to sessions_path , :notice => "please login to vote."
      return
    end
    @vote = View.find_by_post_id_and_user_id(postID,current_user.username)
    if @vote
      redirect_to posts_path , :notice => "You have already voted this post."
      return
    end
    @vote = View.new
    @vote.user_id = current_user.username
    @vote.post_id = postID

    @vote.like = 1

    if @vote.save
       @po.num_likes = @po.num_likes + 1
      @po.save
      redirect_to posts_path , :notice => "The Reply was voted up."
    else
      redirect_to posts_path, :notice => "The reply couldn't be voted"
    end


  end
  def show
    @posts = Post.find(params[:id])
    @reps = Reply.find_all_by_post_id (params[:id])
  end

  def new
    @post=Post.new
    @tags = Tag.all
  end

  def create
    @post=Post.new(params[:post])
           @post.num_likes = 0
  if(current_user)
    @post.user_id = current_user.username
  end
  #  cat = Category.find name:'test1'
   # @post.category_id = cat.cid
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
    if params[:commit] == 'Vote'
    return vote (params[:id])

    end

    @post = Post.find(params[:id])
    if (current_user)
      if(current_user.username == @post.user_id)
        edi = 1
      end
      if(current_user.is_admin == 1)
        edi = 1
      end
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
    if(current_user.is_admin == 1)
      del = 1
    end
  end

    if(del == 1)
      @rep_del = Reply.find_by_post_id(params[:id])
        while @rep_del  do
          @rep_del.destroy
          @rep_del = Reply.find_by_post_id(params[:id])
      end
    @post.destroy
    redirect_to posts_path, :notice => "Your post was updated successfully"
    else
      redirect_to posts_path, :notice => "You can only delete your posts"
    end
    del = 0
  end

end

