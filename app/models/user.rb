class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :rememberable,:omniauthable
  has_many :authentications
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :nickname, :name, :remember_me
  
  def self.find_for_twitter_oauth(omniauth)
    authentication = Authentication.find_by_provider_and_uuid(omniauth['provider'], omniauth['uid'])
    if authentication && authentication.user
      authentication.user
    else
      user = User.create!(:nickname => omniauth['user_info']['nickname'], 
                            :name => omniauth['user_info']['name'])
      user.authentications.create!(:provider => omniauth['provider'], :uuid => omniauth['uid'])
      user.save
      user
    end
  end
end
