module Api
  module V1
    class VerificationsController < BaseController
      def create
        render nothing: true, status: validation.http_status
      end

      private

      def validation
        @_validation ||= validator.validate
      end

      def validator
        ReceiptValidator.new(
          payload: receipt_params,
          user: current_user,
          sandbox: params[:sandbox] || 0,
        )
      end

      def receipt_params
        params.require(:receipt).permit(:data, :token)
      end
    end
  end
end
