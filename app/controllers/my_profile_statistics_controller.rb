class MyProfileStatisticsController < ApplicationController
  before_action :set_my_profile_statistic, only: [:show, :edit, :update, :destroy]

  def index
    @my_profile_statistics = MyProfileStatistic.all
  end

  def show;end

  # GET /my_profile_statistics/new
  def new
    @my_profile_statistic = MyProfileStatistic.new
  end

  def edit;end

  def create
    @my_profile_statistic = MyProfileStatistic.new(my_profile_statistic_params)
    respond_to do |format|
      if @my_profile_statistic.save
        format.html { redirect_to @my_profile_statistic, notice: 'My profile statistic was successfully created.' }
        format.json { render :show, status: :created, location: @my_profile_statistic }
      else
        format.html { render :new }
        format.json { render json: @my_profile_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @my_profile_statistic.update(my_profile_statistic_params)
        format.html { redirect_to @my_profile_statistic, notice: 'My profile statistic was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_profile_statistic }
      else
        format.html { render :edit }
        format.json { render json: @my_profile_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @my_profile_statistic.destroy
    respond_to do |format|
      format.html { redirect_to my_profile_statistics_url, notice: 'My profile statistic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_my_profile_statistic
      @my_profile_statistic = MyProfileStatistic.find(params[:id])
    end

    def my_profile_statistic_params
      params.require(:my_profile_statistic).permit(:profile_id, :post_count, :followers_count, :followings_count)
    end
end
