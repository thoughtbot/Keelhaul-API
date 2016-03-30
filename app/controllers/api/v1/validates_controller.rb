module Api
  module V1
    class ValidatesController < BaseController
      def create
        render json: validation, status: validation.http_status
      end

      private

      def validation
        @_validation ||= validator.validate
      end

      def validator
        ReceiptValidator.new(
          payload: receipt_params,
          user: current_user,
          sandbox: sandbox,
        )
      end

      def sandbox
        params[:sandbox] || "0"
      end

      def receipt_params
        params.require(:receipt).permit!
      end
    end
  end
end
