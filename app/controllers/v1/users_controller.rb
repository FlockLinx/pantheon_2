class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :delete_password_from_params, only: :update

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    # authorize @user
  end

  def edit
    # authorize @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @user.update user_params
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # def destroy
    # whait
  # end


  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :created_by_user_id,
      :active,
      :uid
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def delete_password_from_params
    return unless params[:user][:password].blank?
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end

end