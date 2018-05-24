class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates:name,presence: true ,length:{minimum:4}
         validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
         validates :gender,presence: true, inclusion:{in:[0,1]}
         
         mount_uploader :image, ImageUploader
end
