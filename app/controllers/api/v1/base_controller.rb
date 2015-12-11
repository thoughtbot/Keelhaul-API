module Api
  module V1
    class BaseController < ApplicationController
      before_filter :authenticate

      private

      def authenticate
        authenticate_or_request_with_http_token do |token, _|
          User.find_by(token: token)
        end
      end

      def current_user
        @_current_user ||= authenticate
      end
    end
  end
end
