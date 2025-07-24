class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.all
    render json: users, status: :ok
  end

  def create
    @user = User.new(user_params)
    authorize @user

    # Gerar senha temporária se não fornecida
    if params[:user][:password].blank?
      temp_password = SecureRandom.hex(8)
      @user.password = temp_password
      @user.password_confirmation = temp_password
    end

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def search
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :external_id)
  end
end
