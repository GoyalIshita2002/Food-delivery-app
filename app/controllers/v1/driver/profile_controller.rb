class V1::Driver::ProfileController < ApplicationController
  def update
    @driver=current_driver
    unless current_driver.update(profile_params)
      render json: { status: { code: "400", errors: current_driver.errors.full_messages }}, status: :bad_request and return
    end
  end

  def delete_avatar
    current_driver.avatar.purge
    render json: {status: {code:"200",message:"profile image deleted successfully"}}
  end

  def index
    debugger
    @drivers=Driver.all
  end

  protected

  def profile_params
    params.permit(:full_name, :email, :dob, :address,:avatar)
  end

end
