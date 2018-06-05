class QuestionsController < InheritedResources::Base

  private

    def question_params
      params.require(:question).permit(:content, :user_id , :title)
    end
end

