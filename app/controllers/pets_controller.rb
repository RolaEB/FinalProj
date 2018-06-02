class PetsController < InheritedResources::Base

  private

    def pet_params
      params.require(:pet).permit(:name, :breed, :photo, :price, :phone, :age, :user_id, :description, :country)
    end
  public 
    def index 
     @pets=Pet.all
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
    @students = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
end
    
end
