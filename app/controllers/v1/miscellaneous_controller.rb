class V1::MiscellaneousController < ApplicationController
  skip_before_action :authenticate_user!

  def list
    countries = []
    ISO3166::Country.pluck(:alpha2, :iso_short_name,:country_code).each do |code, name, std|
      countries.push({ code: code, name: name, std_code: std})
    end
    render json: { status:{ code: "200"}, countries: countries},status: :ok 
  end
end
