class ProfileCommentsController < ApplicationController
  before_action :set_profile_comment, only: [:show, :edit, :update, :destroy]

  def index
    @profile_comments = ProfileComment.all
  end

  def show;end

  def new
    @profile_comment = ProfileComment.new
  end

  def edit;end

  def create
    @profile_comment = ProfileComment.new(profile_comment_params)
    if @profile_comment.related_hashtags.nil? || @profile_comment.related_hashtags == ''
      @profile_comment.related_hashtags = MyProfile.find(@profile_comment.profile_id).related_hashtags
    end
    respond_to do |format|
      if @profile_comment.save
        format.html { redirect_to @profile_comment, notice: 'Profile comment was successfully created.' }
        format.json { render :show, status: :created, location: @profile_comment }
      else
        format.html { render :new }
        format.json { render json: @profile_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @profile_comment.update(profile_comment_params)
        format.html { redirect_to @profile_comment, notice: 'Profile comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_comment }
      else
        format.html { render :edit }
        format.json { render json: @profile_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile_comment.destroy
    respond_to do |format|
      format.html { redirect_to profile_comments_url, notice: 'Profile comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def spin_comment
    @comment = ProfileComment.new(content: params[:content]).spin
    respond_to do |format|
      format.js
    end
  end

  private
    def set_profile_comment
      @profile_comment = ProfileComment.find(params[:id])
    end

    def profile_comment_params
      params.require(:profile_comment).permit(:profile_id, :content, :related_hashtags)
    end
end
