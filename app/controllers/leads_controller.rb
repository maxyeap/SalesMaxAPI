class LeadsController < ApplicationController
  before_action :set_lead, only: %i[ show update destroy ]
  before_action :authenticate_user! # Ensure the user is logged in

  # GET /leads
  def index
    @leads = Lead.all

    render json: @leads
  end

  # GET /leads/1
  def show
    render json: @lead
  end

  # POST /leads
  def create
    @lead = current_user.leads.new(lead_params)

    if @lead.save
      render json: @lead, status: :created, location: @lead
    else
      render json: @lead.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      render json: @lead
    else
      render json: @lead.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leads/1
  def destroy
    @lead.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lead_params
      params.require(:lead).permit(:first_name, :last_name, :phone, :email, :time_zone, :city, :country)
    end
end
