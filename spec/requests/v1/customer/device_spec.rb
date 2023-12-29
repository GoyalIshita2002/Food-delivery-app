require 'swagger_helper'

RSpec.describe 'v1/customer/device', type: :request do

  path '/v1/customer/devices' do

    post('create device') do
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
