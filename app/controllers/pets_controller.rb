require 'builder'
#require 'will_paginate'
#include ActionView::Helpers::NumberHelper

class PetsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :check_user,only: [ :edit, :update, :destroy]
  private

    def pet_params
      params.require(:pet).permit(:name, :breed, :photo, :price, :phone, :age, :user_id, :description, :type_id)
    end
  public 
    def index 
    
    
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

 def check_user
  @pet=Pet.find(params[:id])
  if current_user.id != @pet.user_id
    redirect_to(pets_path,notice:"Sorry,you don't have permission to perform this action")
end
 end
    
end

