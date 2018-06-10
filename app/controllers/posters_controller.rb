require 'builder'
require 'will_paginate'
include ActionView::Helpers::NumberHelper

class PostersController < InheritedResources::Base

  private

    def poster_params
      params.require(:poster).permit(:name, :breed, :img, :description, :phone, :last_seen, :user_id, :poster_type)
    end

    public 
    
    def index 
    
     #@carousel=Poster.find(3)
     #for filtering
     @filterrific = initialize_filterrific(
      Poster,
      params[:filterrific],
      :select_options => {
        sorted_by: Poster.options_for_sorted_by
      }
      
    ) or return
    @posters = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
end
    
end

