class ServiceCategoriesController < InheritedResources::Base

  private

    def service_category_params
      params.require(:service_category).permit(:name)
    end
end

