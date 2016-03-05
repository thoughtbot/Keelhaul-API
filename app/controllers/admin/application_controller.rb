module Admin
  class ApplicationController < Administrate::ApplicationController
    include Clearance::Controller
    before_filter :authenticate_admin

    def authenticate_admin
      redirect_to root_url unless current_user.try(:admin?)
    end
  end
end
