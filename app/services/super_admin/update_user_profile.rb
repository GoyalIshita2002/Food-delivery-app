class SuperAdmin::UpdateUserProfile < ApplicationService
  def initialize(params, admin_user)
    @params = params
    @admin_user = admin_user
  end
  
  attr_reader :params, :admin_user

  def call
    admin_user.update(params)
  end
end