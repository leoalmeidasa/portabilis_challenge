# spec/routing/users_routing_spec.rb
require 'rails_helper'

RSpec.describe 'Users routing', type: :routing do
  describe 'API V1 routes' do
    it 'routes to #index' do
      expect(get: '/api/v1/users').to route_to('api/v1/users#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/users/1').to route_to('api/v1/users#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/users').to route_to('api/v1/users#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/users/1').to route_to('api/v1/users#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/users/1').to route_to('api/v1/users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/users/1').to route_to('api/v1/users#destroy', id: '1')
    end

    it 'routes to #inactivate' do
      expect(patch: '/api/v1/users/1/inactivate').to route_to('api/v1/users#inactivate', id: '1')
    end
  end

  describe 'Authentication routes' do
    it 'routes to devise sign in' do
      expect(post: '/auth/sign_in').to route_to('devise_token_auth/sessions#create')
    end

    it 'routes to devise sign out' do
      expect(delete: '/auth/sign_out').to route_to('devise_token_auth/sessions#destroy')
    end

    it 'routes to devise registration' do
      expect(post: '/auth').to route_to('devise_token_auth/registrations#create')
    end
  end
end