class PostsController < ApplicationController

  before_action :authenticate_user!
  def index
    if current_user.profile.nil?
      @prof = "No"
    else
      @prof = "Yes"
    end
    friends = current_user.friends.map{|friend| friend.id}
    @posts = Post.all.select{|post| friends.include?(post.user_id) || post.user_id == current_user.id}
  end

  def show
    @post = Post.find(params[:id])
    if @post.user.profile.nil?
      @prof = "No"
    else
      @prof = @post.user.profile
    end
    
    @like_status = 'Like'
    @count = 0
    @post.likes.each do |like|
      if like.user_id == current_user.id
        @like_status = 'Liked'
        @like = like
      end
      @count += 1
    end
    unless params[:commit].nil?
      unless params[:commit] == "Comment"
        generateLike(@post, params[:commit], @like)
      else
        generateComment(@post, params[:text])
      end
      redirect_to post_path(@post)
    end
    if @post.user == current_user
      @my_post = "True"
    else
      @my_post = "False"
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Give correct information!"
      render :new
    end
  end

  def edit
    @post = Post.new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:content])
      flash[:notice] = "Post updated!"
      redirect_to "/posts"
    else
      flash.now[:alert] = "Give correct information!"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post deleted!"
    redirect_to root_path
  end

  private
    def generateComment(post, text)
      post.comments.create(user_id: current_user.id, text: text)
    end

    def generateLike(post, response, like)
      if like.nil?
        post.likes.create(user_id: current_user.id)
      else
        like.destroy
      end
    end

    def post_params
      params.require(:post).permit(:content,:picture)
    end
end
