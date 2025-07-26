require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  it { should use_before_action(:authenticate_user!) }
end