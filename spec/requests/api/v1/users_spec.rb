# spec/requests/api/v1/users_spec.rb
require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:admin) { create(:user, :admin) }
  let(:regular_user) { create(:user) }
  let(:headers) { admin.create_new_auth_token }

  before { sign_in :admin }

  describe 'GET /api/v1/users' do
    let!(:users) { create_list(:user, 3) }

    context 'with valid authentication' do
      it 'returns all users' do
        get '/api/v1/users', headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(User.count)
      end
    end

    context 'without authentication' do
      it 'returns unauthorized' do
        get '/api/v1/users'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    let!(:user_to_delete) { create(:user, :admin) }

    context 'as admin' do
      it 'deletes the user' do
        expect {
          delete "/api/v1/users/#{user_to_delete.id}", headers: headers
        }.to change(User, :count).by(0)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('User deleted')
      end

      it 'cannot delete themselves' do
        delete "/api/v1/users/#{admin.id}", headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'as regular user' do
      let(:user_headers) { regular_user.create_new_auth_token }

      it 'cannot delete other users' do
        delete "/api/v1/users/#{user_to_delete.id}", headers: user_headers

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PATCH /api/v1/users/:id/inactivate' do
    let!(:active_user) { create(:user, active: true) }
    let!(:inactive_user) { create(:user, :inactive) }

    context 'as admin' do
      it 'toggles user active status from active to inactive' do
        patch "/api/v1/users/#{active_user.id}/inactivate", headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('User desactivated')
        expect(active_user.reload.active).to be false
      end

      it 'toggles user active status from inactive to active' do
        patch "/api/v1/users/#{inactive_user.id}/inactivate", headers: headers

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['error']).to eq('User activated')
        expect(inactive_user.reload.active).to be true
      end

      it 'cannot inactivate themselves' do
        patch "/api/v1/users/#{admin.id}/inactivate", headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'as regular user' do
      let(:user_headers) { regular_user.create_new_auth_token }

      it 'cannot inactivate other users' do
        patch "/api/v1/users/#{active_user.id}/inactivate", headers: user_headers

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end