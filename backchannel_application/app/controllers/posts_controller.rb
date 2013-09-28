class PostsController < ApplicationController


  def search(query , type)
            @po = []
    if type == "1"
    @po = Post.find_all_by_user_id(query)


    elsif type == "2"
     @po = Post.find_all_by_category_name(query)
 #     @po = Post.all
    else
      content = Post.all
      content.each do |desc|
            if /#{query}/ =~ desc.description
              @po << desc
        end

      end

    end

    render :search

    end


  def index

    @posts = Post.order("num_likes desc")

    @users = User.all
    if params[:commit] == 'search'
      return  search(params[:q] , params[:admin])

    end
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
       kk = params[:post]
           @post.num_likes = 0
    tag = Tag.find(kk[:category_name])
    @post.category_name = tag.name

    if kk["category_name"]  == ""
      redirect_to new_post_path() , :notice => "Tag cannot be empty"
      #render "edit" ,  :notice => "Your post was saved successfully."
      return
    end
  if(current_user)
    @post.user_id = current_user.username
  end

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
    kk = params[:post]
    if kk["category_name"]  == ""
      redirect_to edit_post_path(params[:id]) , :notice => "Tag cannot be empty"
      #render "edit" ,  :notice => "Your post was saved successfully."
      return
    end
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