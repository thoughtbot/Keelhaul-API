class UsersController < Clearance::UsersController
  def edit
    @user = current_user
  end

  private

  def url_after_create
    edit_users_path
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to url_after_create
    end
  end
end
