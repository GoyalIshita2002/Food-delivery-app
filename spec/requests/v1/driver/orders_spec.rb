require 'swagger_helper'

RSpec.describe 'v1/driver/orders', type: :request do

  path '/v1/driver/orders/{order_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'order_id', in: :path, type: :string, description: 'order_id'

    put('update order') do
      response(200, 'successful') do
        let(:order_id) { '123' }

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

  path '/v1/driver/{driver_id}/orders' do
    # You'll want to customize the parameter types...
    parameter name: 'driver_id', in: :path, type: :string, description: 'driver_id'

    get('list orders') do
      response(200, 'successful') do
        let(:driver_id) { '123' }

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
