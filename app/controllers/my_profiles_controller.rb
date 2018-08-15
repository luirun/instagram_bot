class MyProfilesController < ApplicationController
  before_action :set_my_profile, except: [:index, :new, :create, :fetch_users]

  def index
    @my_profiles = MyProfile.all
  end

  def show;end

  def new
    @my_profile = MyProfile.new
  end

  def edit; end

  def create
    @my_profile = MyProfile.new(my_profile_params)
    InstagramService.fetch_page_details(@my_profile)
    respond_to do |format|
      if @my_profile.save
        format.html { redirect_to @my_profile, notice: 'My profile was successfully created.' }
        format.json { render :show, status: :created, location: @my_profile }
      else
        format.html { render :new }
        format.json { render json: @my_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @my_profile.update(my_profile_params)
        InstagramService.fetch_page_details(@my_profile)
        format.html { redirect_to @my_profile, notice: 'My profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_profile }
      else
        format.html { render :edit }
        format.json { render json: @my_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @my_profile.destroy
    respond_to do |format|
      format.html { redirect_to my_profiles_url, notice: 'My profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # REVIEW: This action is too stacked
  def automated_profile_promotion
    InstagramService.fetch_page_details(@my_profile)
    pages_urls = @my_profile.pages.pluck(:url)
    photos_comments = Page.fetch_pages_photos_comments(pages_urls)
    Comment.save_photos_comments(photos_comments)
    User.fetch_user_details(User.where(:biography => nil))
    User.delete_unwanted_users
    InstagramService.like_and_follow_users(@my_profile, 5)
    redirect_to my_profiles_path
  end

  def follow_people
    InstagramService.fetch_page_details(@my_profile)
    InstagramService.like_and_follow_users(@my_profile, params[:my_profile][:limit])
    redirect_to my_profiles_path
  end

  def unfollow_people
    # TODO: desreved way -> @my_profile.unfollow_people
    InstagramService.unfollow_people(@my_profile)
  end

  def fetch_users
    @my_profile = MyProfile.find(params[:my_profile_id])
    photos = Page.fetch_pages_photos_comments(@my_profile.pages.pluck(:url))
    Comment.save_photos_comments(photos)
    User.fetch_user_details(User.where(:biography => nil))
    User.delete_unwanted_users
    redirect_to my_profile_path(@my_profile)
  end

  def test
    InstagramService.post_image(@my_profile)
  end

  private
    def set_my_profile
      @my_profile = MyProfile.find(params[:id])
    end

    def my_profile_params
      params.require(:my_profile).permit(:url, :username, :password, :related_hashtags)
    end
end
