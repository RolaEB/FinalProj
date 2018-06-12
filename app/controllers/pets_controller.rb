require 'builder'
#require 'will_paginate'
#include ActionView::Helpers::NumberHelper

class PetsController < InheritedResources::Base
  before_action :authenticate_user!
  private

    def pet_params
      params.require(:pet).permit(:name, :breed, :photo, :price, :phone, :age, :user_id, :description, :type_id)
    end
  public 
    def index 
    
     @carousel=Pet.find(3)
     #for filtering
     @filterrific = initialize_filterrific(
      Pet,
      params[:filterrific],
      :select_options => {
        sorted_by: Pet.options_for_sorted_by,
        with_type_id: Type.options_for_select
      }
      
    ) or return
    @pets = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
end
    
end

