class SessionsController < Clearance::SessionsController
  before_filter :redirect_signed_in_users

  private

  def redirect_signed_in_users
    if signed_in?
      redirect_to edit_users_path
    end
  end
end
