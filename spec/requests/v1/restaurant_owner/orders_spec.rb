require 'swagger_helper'

RSpec.describe 'v1/restaurant_owner/orders', type: :request do

  path '/v1/restaurant_owner/orders/{order_id}' do
    parameter name: 'order_id', in: :path, type: :string, description: 'order_id'

    get('show order') do
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

  path '/v1/restaurant_owner/orders' do

    get('list orders') do
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
