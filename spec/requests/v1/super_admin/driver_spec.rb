require 'swagger_helper'

RSpec.describe 'v1/super_admin/driver', type: :request do

  path '/v1/super_admin/drivers/{driver_id}/revenue_by_day' do
    # You'll want to customize the parameter types...
    parameter name: 'driver_id', in: :path, type: :string, description: 'driver_id'

    get('revenue_by_day driver') do
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

  path '/v1/super_admin/drivers' do

    get('list drivers') do
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

  path '/v1/super_admin/delivery_charges/upsert' do

    post('upsert driver') do
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

  path '/v1/super_admin/drivers/{driver_id}/orders' do
    # You'll want to customize the parameter types...
    parameter name: 'driver_id', in: :path, type: :string, description: 'driver_id'

    get('driver_order_list driver') do
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
