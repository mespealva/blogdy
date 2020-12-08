# frozen_string_literal: true

class Authors::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  
  def create
    admin= Author.first
    u= Author.last
    admin.send(:generate_confirmation_token)
    Devise::Mailer.confirmation_instructions(u, u.instance_variable_get(:@raw_confirmation_token))
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end
  
  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  #def after_resending_confirmation_instructions_path_for(resource_name)
  #  super(resource_name)
  #  posts_path
  #end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    super(resource_name, resource)
    posts_path
  end
end
