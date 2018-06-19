require 'builder'
#require 'will_paginate'
#include ActionView::Helpers::NumberHelper

class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :check_user,only: [ :edit, :update, :destroy]
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

  def check_user
    @question=Question.find(params[:id])
    if current_user.id != @question.user_id
      redirect_to(questions_path,notice:"Sorry,you don't have permission to perform this action")
    end
   end
end

