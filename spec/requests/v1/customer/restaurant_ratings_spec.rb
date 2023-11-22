require 'swagger_helper'

RSpec.describe 'v1/customer/restaurant_ratings', type: :request do

  path '/v1/customer/restaurant_ratings/add_rating' do

    post('add_rating restaurant_rating') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
