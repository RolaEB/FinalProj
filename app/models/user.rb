class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 , :facebook]

         validates:name,presence: true ,length:{minimum:4}
         validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
         validates :gender,presence: true, inclusion:{in:0..2}
         
         mount_uploader :image, ImageUploader

        #for social login
        def self.create_from_provider_data(provider_data)
          where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
            user.email = provider_data.info.email
            user.password = Devise.friendly_token[0, 20]
            user.name= provider_data.info.name
            user.gender= 2
            user.image=provider_data.info.image
            #user.skip_confirmation!
          end
        end

end
