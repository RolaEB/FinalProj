class Pet < ApplicationRecord
    belongs_to :user
    
    #vlidations
    validates:name,presence: { message: "give your pet a name please" } ,length:{minimum:4}
         validates :price, presence: true,numericality: { greater_than_or_equal_to: 0 }
         validates :photo,presence: true
         validates :breed,presence: true
         validates :phone,presence: true
         validates :age,presence: true
         
    #for pet photo
    mount_uploader :photo, PhotoUploader

end
