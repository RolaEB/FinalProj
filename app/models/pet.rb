class Pet < ApplicationRecord
    belongs_to :user
    
    #for pet photo
    mount_uploader :photo, PhotoUploader

end
