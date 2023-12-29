require 'swagger_helper'

RSpec.describe 'v1/super_admin/order', type: :request do
  path '/v1/super_admin/assign_driver/{order_id}' do
    parameter name: 'order_id', in: :path, type: :string, description: 'order_id'
    post('assign_driver order') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: 'Authorization', in: :header, type: :string, description: 'Authentication token'
        parameter name: :order_id, in: :body, schema: {          
          type: :object,          
          properties: {            
            driver_id: { type: :integer },                     
          },          
          required: %w[driver_id]  
        }
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
  
  path '/v1/super_admin/accept_order/{order_id}' do
    parameter name: 'order_id', in: :path, type: :string, description: 'order_id'
    put('accept_order order') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: 'Authorization', in: :header, type: :string, description: 'Authentication token'
        parameter name: :order_id, in: :path, type: :string, required: true
        parameter name: :body, in: :body, schema: {
          type: :object,
          properties: {
            status: { type: :string, enum: ['admin_accepted', 'admin_denied'] },
          },
          required: %w[status]
        }
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
  
  path '/v1/super_admin/placed_order' do
    get('placed_order order') do
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

  path '/v1/super_admin/order_without_driver' do
    get('orders_without_agent order') do
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

  path '/v1/super_admin/restaurant/{restaurant_id}/order_status' do
    # You'll want to customize the parameter types...
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    post('order_status order') do
      response(200, 'successful') do
        let(:restaurant_id) { '123' }

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

  path '/v1/super_admin/orders/statistics' do

    get('order_statistics order') do
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

  path '/v1/super_admin/placed_orders_by_hours' do

    get('placed_orders_by_hours order') do
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

  path '/v1/super_admin/ongoing_orders_statistics' do

    get('orders_ongoing_stats order') do
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

  path '/v1/super_admin/orders_unfilled_stats' do

    get('orders_unfilled_stats order') do
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

  path '/v1/super_admin/orders' do

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
