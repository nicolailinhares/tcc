# encoding: utf-8

# Controller para dar Override em métodos do RegistrationsController do Devise
class RegistrationsController < Devise::RegistrationsController
  def cancel
    super
  end
  def destroy
    super
  end
  
  def new
    super
  end
  
  def create
    super
  end
  
  def edit
    super
  end
  
  protected
  # Redefine para onde o usuário será direcionado após cadastrar
  def after_inactive_sign_up_path_for(resource)
    new_usuario_registration_path
  end
end

