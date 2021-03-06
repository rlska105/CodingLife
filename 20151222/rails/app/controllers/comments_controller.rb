class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        render_create_success(format)
      else
        render_create_fail(format)
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        render_update_success(format)
      else
        render_update_fail(format)
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      message = 'Comment was successfully destroyed.'
      format.html { redirect_to comments_url, notice: message }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body)
  end

  def render_create_success(format)
    message = 'comment was successfully created.'
    format.html { redirect_to @comment, notice: message }
    format.json { render :show, status: :created, location: @comment }
  end

  def render_create_fail(format)
    errors = @comment.errors
    format.html { render :new }
    format.json { render json: errors, status: :unprocessable_entity }
  end

  def render_update_success(format)
    message = 'Comment was successfully updated.'
    format.html { redirect_to @comment, notice: message }
    format.json { render :show, status: :ok, location: @comment }
  end

  def render_update_fail(format)
    errors = @comment.errors
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts errors.inspect
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    format.html { render :edit }
    format.json { render json: errors, status: :unprocessable_entity }
  end
end
