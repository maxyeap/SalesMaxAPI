class DealsController < ApplicationController
  before_action :set_deal, only: %i[ show update destroy ]
  before_action :authenticate_user! # Ensure the user is logged in
  before_action :ensure_current_user, only: %i[ show update destroy ] # Ensure the deal belongs to the current user

  # GET /deals
  def index
    @deals = Deal.all
    render json: { success: true, data: @deals }
  rescue => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end

  # GET /deals/1
  def show
    if @deal
      render json: { success: true, data: @deal }
    else
      render json: { success: false, message: 'Deal not found' }, status: :not_found
    end
  end

  # POST /deals
  def create
    @deal = Deal.new(deal_params)

    if @deal.save
      render json: { success: true, data: @deal }, status: :created, location: @deal
    else
      render json: { success: false, errors: @deal.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deals/1
  def update
    if @deal.update(deal_params)
      render json: { success: true, data: @deal }
    else
      render json: { success: false, errors: @deal.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /deals/1
  def destroy
    if @deal.destroy
      render json: { success: true, message: 'Deal was successfully deleted.' }
    else
      render json: { success: false, message: 'Failed to delete the deal.' }, status: :unprocessable_entity
    end
  rescue => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deal_params
      params.require(:deal).permit(
        :title, :amount, :currency, :status, :stage,
        :close_date, :probability, :lead_id, :priority
      )
    end

    # Ensure the lead belongs to the current user
    def ensure_current_user
      render json: { status: false, error: 'Unauthorized' }, status: :unauthorized unless current_user.deals.include?(@deal)
    end
end
