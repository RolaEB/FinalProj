require 'builder'
#require 'will_paginate'
#include ActionView::Helpers::NumberHelper

class ProductsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :check_store,only: [:new , :edit, :update, :destroy, :create]
  before_action :check_stripe_connected,only: [:new]
  private

    def product_params
      params.require(:product).permit(:name, :price, :description, :user_id, :type_id, :category_id, :brand, :productImage)
    end

    public 
    def index
      @filterrific = initialize_filterrific(
        Product,
        params[:filterrific],
        :select_options => {
        sorted_by: Product.options_for_sorted_by,
        with_type_id: Type.options_for_select,
        with_category_id: Category.options_for_select,
      }
      ) or return
      @products = @filterrific.find.page(params[:page])
   
      respond_to do |format|
        format.html
        format.js
      end
    end
    def check_store
      if current_user.is_store != 1
        redirect_to(products_path,notice:"Sorry,you don't have permission to perform this action")
    end
  end
    def check_stripe_connected
      if current_user.stripe_uid == nil
        redirect_to(event_payment_profile_path,notice:"Please,create a stripe account first")
      end
    end
end

