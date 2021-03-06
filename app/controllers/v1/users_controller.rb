class V1::UsersController < ApplicationController
  resource_description do
    # param_group :global_controllers,  DocumentationHelper
    short 'Users'
  end

  before_action :set_user, only: [:update, :destroy]
  before_action :delete_password_from_params, only: :update
  before_action :authenticate_user!, except: [:create]

  api :GET, '/users', 'Mostra o perfil do usuario logado'
  def index
    @user = current_user
    render json: @user
  end

  api :GET, '/users/search', 'Procura um usuario pelo nome'
  def search
    if params[:name].present?
      @user = current_user.search_by_name params[:name]
      render json: @user
    end
  end

  def new
    @user = User.new
  end

  api :GET, '/users/:id', 'Mostra o perfil do usuario logado'
  def show
    authorize @user
  end

  api :POST, '/users', 'Cria um usuario'
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :PUT, '/users/:id', 'Atualiza um usuario'
  def update
    authorize @user

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
      :secondary_email,
      :password,
      :password_confirmation,
      :created_by_user_id,
      :active,
      :uid,
      phones_attributes: [
        :id,
        :number,
        :_destroy
      ]
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
