require 'builder'
require 'will_paginate'
include ActionView::Helpers::NumberHelper

class ServicesController < InheritedResources::Base

  private

    def service_params
      params.require(:service).permit(:name, :country, :city, :address, :service_category_id, :img, :description, :user_id, :phone)
    end
  public 
  def index
    @filterrific = initialize_filterrific(
      Service,
      params[:filterrific],
      :select_options => {
        sorted_by: Service.options_for_sorted_by,
        with_service_category_id: ServiceCategory.options_for_select,
        
     }
    ) or return
    @services = @filterrific.find.page(params[:page])
 
    respond_to do |format|
      format.html
      format.js
    end
  end
end

