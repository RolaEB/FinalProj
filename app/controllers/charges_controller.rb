class ChargesController < ApplicationController
    def new
    end
    
    def create
      @app_fee= params[:amount] * 0.05
      

      Stripe.api_key = "sk_test_mXLOIO7kwjYPpg80ckqs8VSF"

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
      #token = Stripe::Token.create({
          #  :customer => customer.id,
          #  }, {:stripe_account => params[:account_id]})

            
      charge = Stripe::Charge.create({

        :amount      => params[:amount],
        :description => 'Rails Stripe customer',
        :currency    => 'usd',
        :source       =>"tok_visa",
        :application_fee => params[:amount],
    }, :stripe_account => params[:account_id])
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
