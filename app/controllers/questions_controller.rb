require 'builder'
require 'will_paginate'
include ActionView::Helpers::NumberHelper

class QuestionsController < InheritedResources::Base

  private

    def question_params
      params.require(:question).permit(:content, :user_id , :title)
    end
  
  public 
  def index
    @filterrific = initialize_filterrific(
      Question,
      params[:filterrific],
      :select_options => {
        sorted_by: Question.options_for_sorted_by,
        
      }
    ) or return
    @questions = @filterrific.find.page(params[:page])
 
    respond_to do |format|
      format.html
      format.js
    end
  end

end

