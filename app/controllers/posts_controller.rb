class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    @posts = get_posts
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml  => @posts }
      format.json { render :json => @posts }
      format.atom { render :atom => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    authorize! :new, @post, :message => "Not authorized to create a blog post."
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    authorize! :edit, @post, :message => "Not authorized to edit a blog post."
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    authorize! :create, @post, :message => "Not authorized to create a blog post."
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    authorize! :update, @post, :message => "Not authorized to update a blog post."
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post, :message => "Not authorized to delete a blog post."
    @post.destroy
    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

private
          
  def get_posts
    if params[:tag]
      Post.tagged_with(params[:tag])
    elsif params[:year] && params[:month]
      month = DateTime.new(params[:year].to_i, params[:month].to_i)
      Post.all(:conditions => { :created_at => (month.beginning_of_month)..(month.end_of_month) })
    else
      Post.find(:all, :order => "id DESC")
    end
  end
end
