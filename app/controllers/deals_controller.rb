class DealsController < ApplicationController
  before_action :set_deal, only: %i[ show update destroy ]

  # GET /deals
  def index
    @deals = Deal.all

    render json: @deals
  end

  # GET /deals/1
  def show
    render json: @deal
  end

  # POST /deals
  def create
    @deal = Deal.new(deal_params)

    if @deal.save
      render json: @deal, status: :created, location: @deal
    else
      render json: @deal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deals/1
  def update
    if @deal.update(deal_params)
      render json: @deal
    else
      render json: @deal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deals/1
  def destroy
    @deal.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deal_params
      params.fetch(:deal, {})
    end
end
