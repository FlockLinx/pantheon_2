class V1::PostsController < ApplicationController
  # resource_description do
  #   param_group :global_controllers,  DocumentationHelper
  #   short 'Post'
  # end

  before_action :set_post, only: [:show, :update]
  before_action :authenticate_user!

  # api :GET, '/posts', 'Feed da organization'
  def index
    @post = Post.all
    render json: @post
  end

  # api :GET, '/post/:id', 'Mostra o post'
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

  # api :POST, '/post', 'Cria um novo post
  def create
    @post = Post.new post_params

    # authorize @post

    if @post.save
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
      :donator_id,
      :beneficiary_id,
      :cause,
      :star_amount,
      :amount,
      :tags,
      :organization_id
    )
  end
end
