class LeadsController < ApplicationController
  before_action :set_lead, only: %i[ show update destroy ]
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :ensure_current_user, only: %i[ show update destroy ] # Ensure the lead belongs to the current user

  # GET /leads
  def index
    begin
      @leads = current_user.leads.includes(deals: :activities) # Include deals and their activities
      render json: { success: true, data: @leads.as_json(include: { deals: { include: :activities } }) }, status: :ok
    rescue => e
      render json: { success: false, error: e.message }, status: :internal_server_error
    end
  end

  # GET /leads/1
  def show
    begin
      render json: { success: true, data: @lead.as_json(include: { deals: { include: :activities } }) }, status: :ok
    rescue => e
      render json: { success: false, error: e.message }, status: :internal_server_error
    end
  end

  # POST /leads
  def create
    @lead = current_user.leads.new(lead_params)

    if @lead.save
      render json: { success: true, data: @lead }, status: :created, location: @lead
    else
      render json: { success: false, error: @lead.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      render json: { success: true, data: @lead }, status: :ok
    else
      render json: { success: false, error: @lead.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /leads/1
  def destroy
    if @lead.destroy
      render json: { success: true, message: 'Lead deleted successfully' }, status: :ok
    else
      render json: { success: false, error: @lead.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      render json: { success: false, error: 'Lead not found' }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :phone, :email, :time_zone, :city, :country)
    end

    # Ensure the lead belongs to the current user
    def ensure_current_user
      render json: { status: false, error: 'Unauthorized' }, status: :unauthorized unless current_user.leads.include?(@lead)
    end
end
