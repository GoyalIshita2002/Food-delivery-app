require 'swagger_helper'

RSpec.describe 'v1/miscellaneous', type: :request do

  path '/v1/countries' do

    get('list miscellaneou') do
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
