class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable,
    :two_factor_authenticatable, two_factor_methods: [:otp]

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :otp_enabled, :otp_mandatory, :as => :otp_privileged
  # attr_accessible :email, :password, :password_confirmation, :remember_me
end
