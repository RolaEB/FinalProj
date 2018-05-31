class PetsController < InheritedResources::Base

  private

    def pet_params
      params.require(:pet).permit(:name, :breed, :photo, :price, :phone, :age, :user_id, :description, :country)
    end
  public 
    def index 
     @pets=Pet.all
     @carousel=Pet.find(3)
    end 
    def create
      @pet=Pet.create(pet_params)
      @pet.user_id=current_user.id
      @pet.save
      redirect_to pets_path
    end
end

