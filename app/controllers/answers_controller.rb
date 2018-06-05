class AnswersController < InheritedResources::Base

  private

    def answer_params
      params.require(:answer).permit(:content, :user_id, :question_id)
    end

  public 
   def create 
    @question = Question.find(params[:question_id])
    params.permit!
    @answer = @question.answers.create(params[:answer])

    respond_to do |format|
        format.html { redirect_to question_path(@question) }
        format.js 
    end
   end 
end

