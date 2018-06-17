class ChargesController < ApplicationController
    def new
    end
    
    def create
      @app_fee= params[:amount] * 0.05
      
      
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
      token = Stripe::Token.create({
             :customer => customer.id,
            }, {:stripe_account => params[:account_id]})

    
      charge = Stripe::Charge.create({

        :amount      => params[:amount],
        :description => 'Rails Stripe customer',
        :currency    => 'usd',
        :card     => token.id,
        :application_fee => 200,
    }, :stripe_account => params[:account_id])
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
