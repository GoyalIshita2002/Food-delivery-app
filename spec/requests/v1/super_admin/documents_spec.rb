require 'swagger_helper'

RSpec.describe 'v1/super_admin/documents', type: :request do

  path '/v1/super_admin/restaurant/{restaurant_id}/documents' do
    # You'll want to customize the parameter types...
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'

    post('create document') do
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

    get('list documents') do
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

  path '/v1/super_admin/restaurant/{restaurant_id}/documents/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'restaurant_id', in: :path, type: :string, description: 'restaurant_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete document') do
      response(200, 'successful') do
        let(:restaurant_id) { '123' }
        let(:id) { '123' }

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
