class RepliesController < ApplicationController

  def index
    @replies = Reply.all
  end

  def show
    @reply = Reply.find(params[:id])

  end

  def votereply (postID)

    @reply = Reply.find(postID)
    if(current_user)
      if current_user.username == @reply.user_id
        redirect_to posts_path , :notice => "You cannot vote up your own reply."
        return
      end
    else
      redirect_to sessions_path, :notice => "please login to vote."
      return
    end
    @vote = View.find_by_reply_id_and_user_id(postID,current_user.username)
    if @vote
      redirect_to posts_path , :notice => "You have already voted this Reply post."
      return
    end
    @vote = View.new
    @vote.user_id = current_user.username
    @vote.reply_id = postID

    @vote.like = 1

    if @vote.save
      @reply.num_likes = @reply.num_likes + 1
     @reply.save
      redirect_to posts_path , :notice => "The Reply was voted up."
    else
      redirect_to posts_path, :notice => "The reply couldn't be voted"
    end


  end

  def new
    @reply = Reply.new
    @@postid = params[:id]


  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply=Reply.new(params[:reply])
      @reply.post_id = @@postid
    @reply.num_likes = 0
    if(current_user)
         @reply.user_id = current_user.username
    end
    if @reply.save
      redirect_to posts_path , :notice => "Your reply was saved successfully."
    else
      render "new"
    end
  end

  # PUT /replies/1
  # PUT /replies/1.json
  def update
    if params[:commit] == 'Vote Reply'
      return votereply (params[:id])
    end
    @reply = Reply.find(params[:id])

    if (current_user)
      if(current_user.username == @reply.user_id)
        edi = 1
      end
    end
    if(current_user.is_admin == 1)
      edi = 1
    end
    if(edi == 1)
      if @reply.update_attributes(params[:post])
        redirect_to posts_path, :notice => "Your reply was updated successfully"
      else
        render "edit"
      end
    else
      redirect_to posts_path, :notice => "You can edit only your posts"
    end
    edi = 0
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply = Reply.find(params[:id])

    if (current_user)
      if(current_user.username == @reply.user_id)
        del = 1
      end
      if(current_user.is_admin == 1)
        del = 1
      end
    end

    if(del == 1)
      @reply.destroy
      redirect_to posts_path, :notice => "The reply was deleted successfully"
    else
      redirect_to posts_path, :notice => "You can only delete your posts"
    end
    del = 0
  end
end
