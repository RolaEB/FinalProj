class TypesController < InheritedResources::Base

  private

    def type_params
      params.require(:type).permit(:name)
    end
  
end

