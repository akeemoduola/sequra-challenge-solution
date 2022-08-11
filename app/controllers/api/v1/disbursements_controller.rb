class Api::V1::DisbursementsController < ApplicationController
    def index
        @disbursements = Disbursement.includes(:orders)
        @disbursements = @disbursements.where(week: params['week']) if params['week'].present?
        @disbursements = @disbursements.where(merchant_id: params['merchant_id']) if params['merchant_id'].present?
    
        render json: @disbursements
    end
  
    private
    
      def disbursement_params
        params.require(:disbursement).permit(:merchant_id, :week)
      end
  end
  