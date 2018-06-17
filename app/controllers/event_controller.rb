class EventController < ApplicationController
  def stripe_callback
    options = {
              site: 'https://connect.stripe.com',
              authorize_url: '/oauth/authorize',
              token_url: '/oauth/token'
            }
            code = params[:code]
            client = OAuth2::Client.new(ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['SECRET_KEY'], options)
            @resp = client.auth_code.get_token(code, :params => {:scope => 'read_write'})
            @access_token = @resp.token
            current_user.update!(stripe_uid: @resp.params["stripe_user_id"]) if @resp
            redirect_to(event_payment_profile_path,notice:"Your account has been successfully created and is ready to process payments!")
            
  end

  def payment_profile
    @account = Stripe::Account.retrieve("#{current_user.stripe_uid.to_s}") if current_user.stripe_uid.present?
      @balance = Stripe::Balance.retrieve() if current_user.stripe_uid.present?
  end
end
