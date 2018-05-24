class RegistrationsController < Devise::RegistrationsController

    private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:gender,:image)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:gender,:image)
  end
end
