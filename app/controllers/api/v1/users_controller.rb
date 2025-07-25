class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:destroy, :inactivate]

  def index
    users = User.all
    authorize users
    render json: users, status: :ok
  end

  def search
    users = User.ransack(ransack_params).result
    authorize users
    render json: users, status: :ok
  end

  def destroy
    authorize @user
    if @user.destroy
      render json: { message: 'User deleted' }, status: :ok
    else
      render json: { error: 'Could not complete request' }, status: :unprocessable_entity
    end
  end

  def inactivate
    authorize @user
    if @user.active
      @user.update(active: false)
      render json: { message: 'User desactivated', status: @user.active }, status: :ok
    else
      @user.update(active: true)
      render json: { error: 'User activated', status: @user.active }, status: :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :external_id)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
