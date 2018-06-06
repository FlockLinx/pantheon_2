class V1::PostsController < ApplicationController
  resource_description do
    # param_group :global_controllers,  DocumentationHelper
    short 'Post'
  end

  before_action :set_post, only: [:show, :update]
  before_action :authenticate_user!

  api :GET, '/posts', 'Feed de postagens da empresa'
  def index
    @post = Post.list(current_user).page params[:page]

    authorize @post

    render json: @post
  end

  api :GET, '/post/:id', 'Mostra o post'
  def show
    authorize @post

    render json: @post
  end

  # api :PUT, '/post/:id', 'Atualiza o post'
  def update
    authorize @post

    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :POST, '/post', 'Cria um novo post'
  def create
    @post = Post.new post_params.merge!(donator_id: current_user.id,
                                        organization_id: current_user.organization.id)

    authorize @post
    if @post.valid? && @post.star_exchanges

      @post.beneficiary_star
      @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :beneficiary_id,
      :cause,
      :star_amount,
      :amount,
      tags: []
    )
  end
end
