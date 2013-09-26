class RepliesController < ApplicationController

  def index
    @replies = Reply.all
  end

  def show
    @reply = Reply.find(params[:id])

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
