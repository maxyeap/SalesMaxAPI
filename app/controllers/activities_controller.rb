class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show update destroy ]
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :ensure_current_user, only: %i[ show update destroy ] # Ensure the activity belongs to the current user

  # GET /activities
  def index
    begin
      @activities = current_user.activities
      render json: { success: true, data: @activities }
    rescue => e
      render json: { success: false, message: e.message }, status: :unprocessable_entity
    end
  end

  # GET /activities/1
  def show
    render json: @activity
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      render json: @activity, status: :created, location: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  def update
    if @activity.update(activity_params)
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:title, :description, :activity_type, :start_date, :end_date, :duration, :status, :deal_id)
    end

    def ensure_current_user
      unless current_user.activities.include?(@activity)
        render json: { success: false, message: 'You are not authorized to perform this action' }, status: :unauthorized
      end
    end
end
