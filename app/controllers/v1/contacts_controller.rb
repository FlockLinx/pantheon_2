class V1::ContactsController < ApplicationController
  resource_description do
    # param_group :global_controllers,  DocumentationHelper
    short 'Formulario de Contato - Cria'
    api_versions 'v1'
  end

  api :POST, '/contacts', 'Cria um novo contato de feedback/ajuda'
  param :contact, Hash, required: true do
    param :name, String, required: true
    param :email, String, required: true
    param :phone, String, required: false
    param :subject, String, required: false
    param :origin, String, required: false
    param :message, String, required: true
  end
  def create
    @contact = Contact.new(contact_params)
    @contact.created_by_user_id = current_user.id if current_user

    if @contact.save
      render json: @contact, status: 201
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :name,
      :email,
      :phone,
      :subject,
      :message,
      :origin
    )
  end
end
